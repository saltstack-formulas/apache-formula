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

apache-config-modules-dav_svn_pkg_installed:
  pkg.installed:
    - name: libapache2-mod-svn

apache-config-modules-dav_svn_cmd-run-a2en:
  cmd.run:
    - name: a2enmod dav_svn
    - unless: ls {{ apache.moddir }}/dav_svn.load
    - order: 255
    - require:
      - pkg: apache-package-install-pkg-installed
      - pkg: apache-config-modules-dav_svn_pkg_installed
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

apache-config-modules-dav_svn_cmd-run-a2en-authz:
  cmd.run:
    - name: a2enmod authz_svn
    - unless: ls {{ apache.moddir }}/authz_svn.load
    - order: 255
    - require:
      - pkg: apache-package-install-pkg-installed
      - pkg: apache-config-modules-dav_svn_pkg_installed
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

    {%- endif %}
