# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_running = tplroot ~ '.service.running' %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import apache with context %}

    {%- if 'mod_geoip' in apache and 'finger' in grains and grains.osfinger not in ('Leap-42',) %}

include:
  - {{ sls_service_running }}
  - {{ sls_package_install }}

apache-config-modules-geoip-pkg:
  pkg.installed:
    - pkgs:
      - {{ apache.mod_geoip }}
      - {{ apache.mod_geoip_database }}
    - require:
      - pkg: apache-package-install-pkg-installed
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

        {%- if grains['os_family']=="RedHat" %}

apache-config-modules-geoip-conf-file-managed:
  file.managed:
    - name: {{ apache.confdir }}/geoip.conf
    - user: {{ apache.rootuser }}
    - group: {{ apache.rootgroup }}
    - makedirs: True
    - mode: 644
    - template: {{ apache.get('template_engine', 'jinja') }}
    - context:
      apache: {{ apache|json }}
    - source:
      - salt://apache/files/{{ salt['grains.get']('os_family') }}/geoip.conf

apache-config-modules-geoip-db-file-managed:
  file.managed:
    - name: /usr/share/GeoIP/GeoIP.dat
    - user: {{ apache.rootuser }}
    - group: {{ apache.rootgroup }}
    - makedirs: True
    - mode: 644
    - source:
      - salt://apache/files/{{ salt['grains.get']('os_family') }}/GeoIP.dat

apache-config-modules-geoip-{{ grains.os_family }}-conf-file-managed:
  file.managed:
    - name: {{ apache.moddir }}/10-geoip.conf
    - makedirs: True
    - source:
      - salt://apache/files/RedHat/conf.modules.d/10-geoip.conf.jinja
    - require:
      - pkg: apache-package-install-pkg-installed
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

        {%- elif grains['os_family'] in ('Suse', 'Debian',) %}

apache-config-modules-geoip-cmd-run:
  cmd.run:
    - name: a2enmod geoip
    - unless: ls {{ apache.moddir }}/geoip.load || egrep "^APACHE_MODULES=" /etc/sysconfig/apache2 | grep geoip
    - order: 255
    - require:
      - pkg: apache-package-install-pkg-installed
      - pkg: apache-config-modules-geoip-pkg
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

        {%- endif %}
    {%- endif %}
