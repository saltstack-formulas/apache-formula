# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_running = tplroot ~ '.service.running' %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import apache with context %}

include:
  - {{ sls_service_running }}
  - {{ sls_package_install }}

    {%- if grains['os_family'] in ('Debian', 'Suse') %}

apache-config-modules-ssl-cmd-run:
  cmd.run:
    - name: a2enmod ssl
    - unless: ls {{ apache.moddir }}/ssl.load || egrep "^APACHE_MODULES=" /etc/sysconfig/apache2 | grep ' ssl'
    - order: 225
    - require:
      - pkg: apache-package-install-pkg-installed
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running
  file.managed:
    - name: /etc/apache2/mods-available/ssl.conf
    - source: salt://apache/files/{{ salt['grains.get']('os_family') }}/ssl.conf.jinja
    - template: {{ apache.get('template_engine', 'jinja') }}
    - context:
      apache: {{ apache|json }}
    - mode: 644
    - makedirs: True
    - watch_in:
      - module: apache-service-running-restart

    {%- elif grains['os_family']=="RedHat" %}

apache-config-modules-ssl-pkg:
  pkg.installed:
    - name: {{ apache.pkg.mod_ssl }}
    - require:
      - pkg: apache-package-install-pkg-installed
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running
  file.absent:
    - name: {{ apache.confdir }}/ssl.conf
    - require:
      - pkg: apache-package-install-pkg-installed
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

    {%- elif grains['os_family']=="FreeBSD" %}
  - .mod_ssl

apache-config-modules-ssl-file-managed:
  file.managed:
    - name: {{ apache.modulesdir }}/010_mod_ssl.conf
    - source: salt://apache/files/{{ salt['grains.get']('os_family') }}/mod_ssl.conf.jinja
    - mode: 644
    - makedirs: True
    - template: {{ apache.get('template_engine', 'jinja') }}
    - context:
      apache: {{ apache|json }}
    - require:
      - pkg: apache-package-install-pkg-installed
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

    {%- endif %}

apache-config-modules-ssl-file-managed-tls-defaults:
    {%- if salt['pillar.get']('apache:mod_ssl:manage_tls_defaults', False) %}
  file.managed:
    - name: {{ apache.confdir }}/tls-defaults.conf
    - source: salt://apache/files/ssl/tls-defaults.conf.jinja
    - mode: 644
    - makedirs: True
    - template: {{ apache.get('template_engine', 'jinja') }}
    - context:
      apache: {{ apache|json }}
    {%- else %}
  file.absent:
    - name: {{ apache.confdir }}/tls-defaults.conf
    {%- endif %}
    - require:
      - pkg: apache-package-install-pkg-installed
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

    {%- if grains['os_family'] in ('Debian',) %}
apache-config-modules-ssl-cmd-run-debian-tls-defaults:
  cmd.run:
       {%- if salt['pillar.get']('apache:mod_ssl:manage_tls_defaults', False) %}
    - name: a2enconf tls-defaults
    - unless: test -L /etc/apache2/conf-enabled/tls-defaults.conf
       {%- else %}
    - name: a2disconf tls-defaults
    - onlyif: test -L /etc/apache2/conf-enabled/tls-defaults.conf
       {%- endif %}
    - order: 225
    - require:
      - pkg: apache-package-install-pkg-installed
      - file: {{ apache.confdir }}/tls-defaults.conf
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running
    {%- endif %}
