# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_running = tplroot ~ '.service.running' %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import apache with context %}

    {%- if grains['os_family']=="FreeBSD" %}

include:
  - {{ sls_service_running }}
  - {{ sls_package_install }}

apache-config-modules-cgi-cmd-run:
  file.managed:
    - name: {{ apache.modulesdir }}/040_mod_cgi.conf
    - source: salt://apache/files/FreeBSD/mod_cgi.conf.jinja
    - template: {{ apache.get('template_engine', 'jinja') }}
    - makedirs: True
    - context:
        svcname: {{ apache.service.name }}
    - require:
      - pkg: apache-package-install-pkg-installed
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running
    - mode: 644

    {%- endif %}
