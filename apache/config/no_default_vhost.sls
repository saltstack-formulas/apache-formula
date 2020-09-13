# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- set sls_service_running = tplroot ~ '.service.running' %}
{%- from tplroot ~ "/map.jinja" import apache with context %}

    {%- if grains.os_family == "Debian" %}

include:
  - {{ sls_package_install }}
  - {{ sls_service_running }}

apache-config-default-vhost:
  cmd.run:
    - name: a2dissite 000-default.conf || true
    - unless: test ! -f /etc/apache2/sites-enabled/000-default.conf
    - require:
      - pkg: apache-package-install-pkg-installed
    - watch_in:
      - module: apache-service-running-reload
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

    {%- endif %}
