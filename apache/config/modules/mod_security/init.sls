# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_running = tplroot ~ '.service.running' %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import apache with context %}

include:
  - {{ sls_service_running }}
  - {{ sls_package_install }}

    {%- if grains.os_family not in ('Arch',) %}

apache-config-modules-security-pkg:
  pkg.installed:
    - name: {{ apache.mod_security.package }}
    - order: 180
    - require:
      - pkg: apache-package-install-pkg-installed
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

        {%- if apache.mod_security.crs_install and 'crs_package' in apache.mod_security %}

apache-config-modules-security-crs-pkg:
  pkg.installed:
    - name: {{ apache.mod_security.crs_package }}
    - order: 180
    - require:
      - pkg: apache-config-modules-security-pkg
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

        {%- endif %}
        {%- if apache.mod_security.manage_config and 'config_file' in apache.mod_security %}

apache-config-modules-security-main-config-file-managed:
  file.managed:
    - name: {{ apache.mod_security.config_file }}
    - order: 220
    - makedirs: True
    - template: {{ apache.get('template_engine', 'jinja') }}
    - context:
      apache: {{ apache|json }}
    - source:
      - {{ 'salt://apache/files/' ~ salt['grains.get']('os_family') ~ '/modsecurity.conf.jinja' }}
    - context: {{ apache.mod_security|json }}
    - require:
      - pkg: apache-config-modules-security-pkg
    - watch_in:
      - module: apache-service-running-reload
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

        {%- endif %}
        {%- if grains['os_family'] in ('Suse', 'Debian',) %}

apache-config-modules-security-cmd-run-a2en-security2:
  cmd.run:
    - name: a2enmod security2
    - unless: ls {{ apache.moddir }}/security2.load && ls {{ apache.moddir }}/security2.conf
    - order: 225

        {%- elif grains.os_family in ('Redhat',) %}
apache-config-modules-security-file-directory-modsecurity:
  file.directory:
    - name: /etc/httpd/modsecurity.d
        {%- endif %}

    - require:
      - pkg: apache-config-modules-security-pkg
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running
    {%- endif %}
