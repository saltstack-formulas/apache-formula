# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_running = tplroot ~ '.service.running' %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import apache with context %}
{%- set mpm_module = salt['pillar.get']('apache:mpm:module', 'mpm_prefork') %}

include:
  - {{ sls_service_running }}
  - {{ sls_package_install }}

    {%- if grains['os_family'] in ('Suse', 'Debian',) %}

apache-config-modules-mpm-pkg:
  cmd.run:
    - name: a2enmod {{ mpm_module }}
    - unless: ls {{ apache.moddir }}/{{ mpm_module }}.load
    - require:
      - pkg: apache-package-install-pkg-installed
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running
  file.managed:
    - name: /etc/apache2/mods-available/{{ mpm_module }}.conf
    - template: {{ apache.get('template_engine', 'jinja') }}
    - makedirs: True
    - context:
      apache: {{ apache|json }}
    - source:
      - salt://apache/files/Debian/mpm/{{ mpm_module }}.conf.jinja
    - require:
      - pkg: apache-package-install-pkg-installed
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

         # Deactivate the other mpm modules as a previous step
         {%- for mod in ['mpm_prefork', 'mpm_worker', 'mpm_event'] if not mod == mpm_module %}

apache-config-modules-mpm-{{ mod }}-cmd-run:
  cmd.run:
    - name: a2dismod {{ mod }}
    - onlyif: ls {{ apache.moddir }}/{{ mod }}.load || egrep "^APACHE_MODULES=" /etc/sysconfig/apache2 | grep ' {{ mod }}'
    - require:
      - pkg: apache-package-install-pkg-installed
    - require_in:
      - cmd: a2enmod {{ mpm_module }}
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

         {%- endfor %}
    {%- elif grains['os_family']=="RedHat" %}

apache-config-modules-mpm-{{ grains.os_family }}-conf-file-managed:
  file.managed:
    - name: {{ apache.moddir }}/00-mpm.conf
    - template: {{ apache.get('template_engine', 'jinja') }}
    - makedirs: True
    - context:
      apache: {{ apache|json }}
    - source:
      - salt://apache/files/RedHat/conf.modules.d/00-{{ mpm_module }}.conf.jinja
    - require:
      - pkg: apache-package-install-pkg-installed
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

    {%- endif %}
