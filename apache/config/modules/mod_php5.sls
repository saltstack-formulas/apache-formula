# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_running = tplroot ~ '.service.running' %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import apache with context %}

include:
  - {{ sls_service_running }}
  - {{ sls_package_install }}


apache-config-modules-php5-pkg:
  pkg.installed:
    - name: {{ apache.mod_php5 }}
    - order: 180
    - require:
      - pkg: apache-package-install-pkg-installed

    {%- if grains['os_family'] in ('Suse', 'Debian',) %}

  cmd.run:
    - name: a2enmod php5
    - unless: ls {{ apache.moddir }}/php5.load || egrep "^APACHE_MODULES=" /etc/sysconfig/apache2 | grep ' php5'
    - order: 225
    - require:
      - pkg: apache-config-modules-php5-pkg
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

        {%- if 'apache' in pillar and 'php-ini' in pillar['apache'] %}

  file.managed:
    - name: /etc/php5/apache2/php.ini
    - source: {{ pillar['apache']['php-ini'] }}
    - order: 225
    - makedirs: True
    - template: {{ apache.get('template_engine', 'jinja') }}
    - context:
        svcname: {{ apache.service.name }}
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running
    - require:
      - pkg: apache-package-install-pkg-installed
      - pkg: apache-config-modules-php5-pkg

        {%- endif %}
    {%- elif grains['os_family']=="FreeBSD" %}

  file.managed:
    - name: {{ apache.modulesdir }}/050_mod_php5.conf
    - source: salt://apache/files/{{ salt['grains.get']('os_family') }}/mod_php5.conf.jinja
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

    {%- elif grains['os_family']=="Suse" %}

  file.replace:
    - name: /etc/sysconfig/apache2
    - unless: grep '^APACHE_MODULES=.*php5' /etc/sysconfig/apache2
    - pattern: '^APACHE_MODULES=(.*)"'
    - repl: 'APACHE_MODULES=\1 php5"'

    {%- endif %}
