# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_running = tplroot ~ '.service.running' %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import apache with context %}

include:
  - {{ sls_service_running }}
  - {{ sls_package_install }}

    {%- if grains['os_family'] in ('Suse', 'Debian',) %}

apache-config-modules-remoteip-cmd-run-mod-a2en:
  cmd.run:
    - name: a2enmod remoteip
    - unless: ls {{ apache.moddir }}/remoteip.load || egrep "^APACHE_MODULES=" /etc/sysconfig/apache2 | grep remoteip
    - order: 255
    - require:
      - pkg: apache-package-install-pkg-installed
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

apache-config-modules-remoteip-cmd-run-conf:
  cmd.run:
    - name: a2enconf remoteip
    - unless: ls /etc/apache2/conf-enabled/remoteip.conf
    - order: 255
    - require:
      - pkg: apache-package-install-pkg-installed
    - watch_in:
      - module: apache-service-running-reload
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running
  file.managed:
    - name: /etc/apache2/conf-available/remoteip.conf
    - template: {{ apache.get('template_engine', 'jinja') }}
    - makedirs: True
    - context:
      apache: {{ apache|json }}
    - source:
      - salt://apache/files/{{ salt['grains.get']('os_family') }}/conf-available/remoteip.conf.jinja
    - require:
      - pkg: apache-package-install-pkg-installed
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running
      - cmd: apache-config-modules-remoteip-cmd-run-conf

    {%- elif grains['os_family']=="RedHat" %}

apache-config-modules-remoteip-file-managed-conf:
  file.managed:
    - name: /etc/httpd/conf.d/remoteip.conf
    - template: {{ apache.get('template_engine', 'jinja') }}
    - makedirs: True
    - context:
      apache: {{ apache|json }}
    - source:
      - salt://apache/files/{{ salt['grains.get']('os_family') }}/conf.modules.d/remoteip.conf.jinja
    - require:
      - pkg: apache-package-install-pkg-installed
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

    {%- endif %}
