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

apache-config-modules-suexec-file-managed:
  file.managed:
    - name: {{ apache.modulesdir }}/040_mod_suexec.conf
    - source: salt://apache/files/{{ salt['grains.get']('os_family') }}/mod_suexec.conf.jinja
    - mode: 644
    - makedirs: True
    - template: {{ apache.get('template_engine', 'jinja') }}
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

    {%- endif %}
