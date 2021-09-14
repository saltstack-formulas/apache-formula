# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_running = tplroot ~ '.service.running' %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import apache with context %}

    {%- if grains['os_family'] == "Debian" %}

include:
  - {{ sls_service_running }}
  - {{ sls_package_install }}
  - .mod_actions

apache-config-modules-fastcgi-pkg:
  pkgrepo.managed:
    - name: "deb http://ftp.us.debian.org/debian {{ grains['oscodename'] }}"
    - file: /etc/apt/sources.list.d/non-free.list
    - onlyif: grep Debian /proc/version >/dev/null 2>&1
    - comps: non-free
  pkg.installed:
    - name: {{ apache.mod_fastcgi }}
    - order: 180
    - require:
      - pkgrepo: apache-config-modules-fastcgi-pkg
      - pkg: apache-package-install-pkg-installed
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

apache-config-modules-fastcgi_cmd-run:
  cmd.run:
    - name: a2enmod fastcgi
    - unless: ls {{ apache.moddir }}/fastcgi.load
    - order: 225
    - require:
      - pkg: apache-config-modules-fastcgi-pkg
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

    {%- endif %}
