# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_running = tplroot ~ '.service.running' %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import apache with context %}

include:
  - {{ sls_service_running }}
  - {{ sls_package_install }}

apache-config-modules-perl-pkg:
  pkg.installed:
    - name: {{ apache.mod_perl2 }}
    - order: 180
    - require:
      - pkg: apache-package-install-pkg-installed
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

    {%- if grains['os_family'] in ('Suse', 'Debian',) %}

  cmd.run:
    - name: a2enmod perl
    - unless: ls {{ apache.moddir }}/perl.load || egrep "^APACHE_MODULES=" /etc/sysconfig/apache2 | grep ' perl'
    - order: 225
    - require:
      - pkg: apache-config-modules-perl-pkg
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

    {%- elif grains['os_family']=="FreeBSD" %}

  file.managed:
    - name: {{ apache.modulesdir }}/260_mod_perl.conf
    - source: salt://apache/files/{{ salt['grains.get']('os_family') }}/mod_perl.conf.jinja
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
