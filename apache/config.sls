{% from "apache/map.jinja" import apache with context %}
{% import_yaml "apache/hardening-values.yaml" as hardening_values %}
{% import_yaml "apache/defaults/" ~ salt['grains.get']('os_family') ~ "/defaults-apache-" ~  apache.version ~ ".yaml" as global_defaults %}

include:
  - apache
  - apache.mod_ssl
  - apache.hardening

{# merge defaults with pillar content #}
{% set pillar_server_config = salt['pillar.get']('apache:server_apache_config', {}) %}
{% set server_config = salt['apache_directives.merge_container_with_additional_data'](
                              global_defaults.server_apache_config,
                              pillar_server_config) %}

{# enforce directives values #}
{% for directive, directive_data in hardening_values.enforced_directives.items() %}
{% set server_config = salt['apache_directives.enforce_directive_value'](directive,
                  directive_data,
                  container_name='server',
                  container_data=server_config) %}
{% endfor %}

{# merge server config with hardened sections #}
{% set server_config = salt['apache_directives.enforce_security_directives_into_containers'](
                                server_config,
                                hardening_values.enforced_containers ) %}

{# remove containers #}
{% for container_name_to_remove, items_names in hardening_values.containers_to_remove.items() %}
{% for item_name in items_names %}
{% set server_config = salt['apache_directives.remove_container'](
                                server_config,
                                container_name_to_remove,
                                item_name) %}
{% endfor %}
{% endfor %}

{# add supplemental security directives in server configuration #}
{% for d_directive in hardening_values.server_supplemental_directives %}
{% for directive, value in d_directive.items() %}
{% set server_config = salt['apache_directives.append_to_container_directives'](
                                      directive,
                                      value,
                                      server_config) %}
{% endfor %}
{% endfor %}

{% if grains['os_family']=="RedHat" %}

{{ apache.logdir }}:
  file.directory:
    - makedirs: True
    - require:
      - pkg: apache
    - user: root
    - group: {{ apache.group }}
    - dir_mode: 750
    - watch_in:
      - module: apache-restart
    - require_in:
      - module: apache-restart
      - module: apache-reload
      - service: apache

{{ apache.configfile }}:
  file.managed:
    - template: jinja
    - source:
      - salt://apache/files/{{ salt['grains.get']('os_family') }}/apache-{{ apache.version }}.config.jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart
    - require_in:
      - module: apache-restart
      - module: apache-reload
      - service: apache
    - context:
        apache: {{ apache }}
        server_config: {{ server_config | json }}

{{ apache.vhostdir }}:
  file.directory:
    - makedirs: True
    - require:
      - pkg: apache
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - recurse:
      - user
      - group
      - mode
    - watch_in:
      - module: apache-restart
    - require_in:
      - module: apache-restart
      - module: apache-reload
      - service: apache


/etc/httpd/conf.d/welcome.conf:
  file.managed:
    - source:
      - salt://apache/files/{{ salt['grains.get']('os_family') }}/welcome.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: apache
    - watch_in:
      - service: apache
{% endif %}
