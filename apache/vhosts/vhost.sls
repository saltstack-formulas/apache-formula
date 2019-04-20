{% from "apache/map.jinja" import apache with context %}
{% import_yaml "apache/hardening-values.yaml" as hardening_values %}

include:
  - apache

{% set vhosts = salt['pillar.get']('apache:VirtualHost', {}) %}

{% for virtual_name, vhost in vhosts.items() %}

{% set vhost_server_name = salt['apache_directives.get_directive_single_value'](
                                    'ServerName',
                                    vhost.get('directives'),
                                    default=virtual_name) %}
{% set vhost = salt['apache_directives.enforce_directive_value'](directive='ServerName',
                      enforced_directive_data={'value': vhost_server_name,
                                               'add_if_absent': True},
                      container_name='VirtualHost',
                      container_data=vhost) %}
{% set default_documentroot = '{0}/{1}'.format(apache.wwwdir, vhost_server_name) %}
{% set documentroot = salt['apache_directives.get_directive_single_value'](
                                  'DocumentRoot',
                                  vhost.get('directives'),
                                  default=default_documentroot) %}
{% set vhost = salt['apache_directives.set_vhost_logging_directives'](vhost,
                                                          vhost_server_name,
                                                          apache.logdir) %}

# enforce directives values #

{% for directive, directive_data in hardening_values.enforced_directives.items() %}
{% if 'add_if_absent' in directive_data %}
{% do directive_data.update({'add_if_absent': False}) %}
{% endif %}
{% set vhost = salt['apache_directives.enforce_directive_value'](directive,
                                            directive_data,
                                            container_name='VirtualHost',
                                            container_data=vhost) %}
{% endfor %}

# merge vhost config with hardened sections #
{% set vhost = salt['apache_directives.enforce_security_directives_into_containers'](
                                vhost,
                                hardening_values.enforced_containers,
                                add_container=False ) %}

# remove containers #
{% for container_name_to_remove, items_names in hardening_values.containers_to_remove.items() %}
{% for item_name in items_names %}
{% set vhost = salt['apache_directives.remove_container'](
                                vhost,
                                container_name_to_remove,
                                item_name) %}
{% endfor %}
{% endfor %}

# add supplemental security directives in vhost configuration #
{% for d_directive in hardening_values.vhost_supplemental_directives %}
{% for directive, value in d_directive.items() %}
{% set vhost = salt['apache_directives.append_to_container_directives'](
                                      directive,
                                      value,
                                      vhost) %}
{% endfor %}
{% endfor %}

{% if vhost.get('absent', False) %}
{{ vhost_server_name }}:
  file.absent:
    - name: {{ apache.vhostdir }}/{{ vhost_server_name }}{{ apache.confext }}
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-reload
    - require_in:
      - module: apache-restart
      - module: apache-reload
      - service: apache

{% else %}


{{ vhost_server_name }}:
  file.managed:
    - name: {{ apache.vhostdir }}/{{ vhost_server_name }}{{ apache.confext }}
    - source: 'salt://apache/vhosts/vhost.conf.jinja'
    - template: 'jinja'
    - user: root
    - group: root
    - mode: 644
    - context:
        vhost_data: {{ vhost|json }}
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-reload
    - require_in:
      - module: apache-restart
      - module: apache-reload
      - service: apache


{{ documentroot }}-documentroot:
  file.directory:
    - name: {{ documentroot }}
    - makedirs: True
    - allow_symlink: True

{% endif %}
{% endfor %}
