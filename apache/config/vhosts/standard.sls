# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- set sls_service_running = tplroot ~ '.service.running' %}
{%- from tplroot ~ "/map.jinja" import apache with context %}
{#- The apache variable can grow _very_ large, especially the sites subkey.
    Create a trimmed copy with config variables. #}
{%- set map = apache %}
{%- do map.pop('sites', None) %}

include:
  - {{ sls_package_install }}
  - {{ sls_service_running }}

  {%- for id, site in salt['pillar.get']('apache:sites', {}).items() %}
      {%- set documentroot = site.get('DocumentRoot', '{0}/{1}'.format(apache.wwwdir, site.get('ServerName', id))) %}

apache-config-vhosts-standard-{{ id }}:
  file.managed:
    - name: {{ apache.vhostdir }}/{{ id }}{{ apache.confext }}
    - source: {{ site.get('template_file', 'salt://apache/config/vhosts/standard.tmpl') }}
    - template: {{ apache.get('template_engine', 'jinja') }}
    - makedirs: True
    - context:
        id: {{ id|json }}
        site: {{ site|json }}
        map: {{ map|json }}
    - require:
      - pkg: apache-package-install-pkg-installed
    - watch_in:
      - module: apache-service-running-reload
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

      {%- if site.get('DocumentRoot') != False %}

apache-config-vhosts-standard-{{ id }}-docroot:
  file.directory:
    - name: {{ documentroot }}
    - makedirs: True
    - user: {{ site.get('DocumentRootUser', apache.get('document_root_user'))|json or apache.user }}
    - group: {{ site.get('DocumentRootGroup', apache.get('document_root_group'))|json or apache.group }}
    - allow_symlink: True

      {%- endif %}
      {%- if grains.os_family == 'Debian' %}
          {%- if site.get('enabled', True) %}

apache-config-vhosts-standard-{{ id }}-cmd-run-a2en:
  cmd.run:
    - name: a2ensite {{ id }}{{ apache.confext }}
    - unless: test -f /etc/apache2/sites-enabled/{{ id }}{{ apache.confext }}
    - require:
      - file: apache-config-vhosts-standard-{{ id }}
    - watch_in:
      - module: apache-service-running-reload
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

          {%- else %}

apache-config-vhosts-standard-{{ id }}-cmd-run-a2dis:
  cmd.run:
    - name: a2dissite {{ id }}{{ apache.confext }}
    - onlyif: test -f /etc/apache2/sites-enabled/{{ id }}{{ apache.confext }}
    - require:
      - file: apache-config-vhosts-standard-{{ id }}
    - watch_in:
      - module: apache-service-running-reload
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

          {%- endif %}
      {%- endif %} {# Debian #}
  {%- endfor %}
