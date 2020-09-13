# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import apache with context %}

include:
  - {{ sls_package_install }}

apache-config-server-status:
  file.managed:
    - name: {{ apache.confdir }}/server-status{{ apache.confext }}
    - source: 'salt://apache/files/server-status.conf.jinja'
    - template: {{ apache.get('template_engine', 'jinja') }}
    - makedirs: True
    - context:
        apache: {{ apache|json }}
    - require:
      - pkg: apache-package-install-pkg-installed
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

    {%- if grains['os_family'] == "Debian" %}

apache-config-server-status-file-directory:
  file.directory:
    - name: /etc/apache2/conf-enabled
    - require:
      - pkg: apache-package-install-pkg-installed

apache-config-server-status-cmd-run:
  cmd.run:
    - name: a2enconf server-status
    - unless: 'test -L /etc/apache2/conf-enabled/server-status.conf'
    - order: 225
    - require:
      - pkg: apache-package-install-pkg-installed
      - file: apache-config-server-status
      - file: apache-config-server-status-file-directory
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

    {%- endif %}
