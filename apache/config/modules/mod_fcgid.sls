# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_running = tplroot ~ '.service.running' %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import apache with context %}

include:
  - {{ sls_service_running }}
  - {{ sls_package_install }}

apache-config-modules-fcgid-pkg:
  pkg.installed:
    - name: {{ apache.mod_fcgid }}
    - order: 180
    - require:
      - pkg: apache-package-install-pkg-installed

    {%- if grains['os_family'] in ('Suse', 'Debian',) %}

  cmd.run:
    - name: a2enmod fcgid
    - order: 225
    - unless: ls {{ apache.moddir }}/fcgid.load || egrep "^APACHE_MODULES=" /etc/sysconfig/apache2 | grep ' fcgid'
    - require:
      - pkg: apache-config-modules-fcgid-pkg
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

    {%- endif %}
