# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- set sls_service_running = tplroot ~ '.service.running' %}
{%- from tplroot ~ "/map.jinja" import apache with context %}

    {%- if grains.os_family in ('Debian', 'FreeBSD') %}

include:
  - {{ sls_package_install }}
  - {{ sls_service_running }}

apache-config-manage-security-{{ grains.os_family }}:
  file.managed:
        {%- if grains.os_family == "Debian" %}

    - onlyif: test -f /etc/apache2/conf-available/security.conf
    - name: /etc/apache2/conf-available/security.conf

        {%- elif grains.os_family == "FreeBSD" %}

    - name: {{ apache.confdir + '/security.conf' }}

        {%- endif %}
    - source:
      - salt://apache/files/{{ grains.os_family }}/security.conf.jinja
      - salt://apache/files/ssl/security.conf.jinja
    - mode: 644
    - makedirs: True
    - template: {{ apache.get('template_engine', 'jinja') }}
    - context:
      apache: {{ apache | json }}
    - require:
      - pkg: apache-package-install-pkg-installed
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

    {%- endif %}
