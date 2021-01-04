# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_running = tplroot ~ '.service.running' %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import apache with context %}

include:
  - {{ sls_service_running }}
  - {{ sls_package_install }}
  - .mod_proxy

    {%- if grains['os_family'] in ('Suse', 'Debian',) %}

apache-config-modules-proxy_http-pkg:
  cmd.run:
    - name: a2enmod proxy_http
    - unless: ls {{ apache.moddir }}/proxy_http.load || egrep "^APACHE_MODULES=" /etc/sysconfig/apache2 | grep proxy_http
    - order: 225
    - require:
      - pkg: apache-package-install-pkg-installed
      # cmd: a2enmod proxy
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

    {%- elif grains['os_family']=="FreeBSD" %}

apache-config-modules-proxy_http-file-managed:
  file.managed:
    - name: {{ apache.modulesdir }}/040_mod_proxy_http.conf
    - source: salt://apache/files/{{ salt['grains.get']('os_family') }}/mod_proxy_http.conf.jinja
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
