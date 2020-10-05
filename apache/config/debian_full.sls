# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- set sls_service_running = tplroot ~ '.service.running' %}
{%- set sls_config_registersite = tplroot ~ '.config.register_site' %}
{%- from tplroot ~ "/map.jinja" import apache with context %}

    {%- if grains.os_family in ('Debian',) %}

include:
  - {{ sls_package_install }}
  - {{ sls_service_running }}
  - {{ sls_config_registersite }}

extend:
  apache-package-install-pkg-installed:
    pkg:
      - order: 175
  apache-service-running:
    service:
      - order: 455
  apache-service-running-reload:
    module:
      - order: 420
  apache-service-running-restart:
    module:
      - order: 425

apache-config-debian-full-cmd-run:
  cmd.run:
    - name: a2dissite 000-default{{ apache.confext }} || true
    - onlyif: test -f /etc/apache2/sites-enabled/000-default{{ apache.confext }}
    - watch_in:
      - module: apache-service-running-reload
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running
    - require:
      - pkg: apache-package-install-pkg-installed
  file.absent:
    - names:
      - /etc/apache2/sites-available/{{ apache.default_site }}
      - /etc/apache2/sites-available/{{ apache.default_site_ssl }}
    - require:
      - pkg: apache-package-install-pkg-installed

    {%- endif %} #END: os = debian
