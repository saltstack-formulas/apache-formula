# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_running = tplroot ~ '.service.running' %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import apache with context %}
{%- set pagespeed_module = salt['pillar.get']('apache:pagespeed:module', 'pagespeed_prefork') %}

include:
  - {{ sls_service_running }}
  - {{ sls_package_install }}

    {%- if grains['os_family'] in ('Suse', 'Debian',) %}

apache-config-modules-pagespeed-pkg:
  pkg.installed:
    - name: {{ apache.mod_pagespeed }}
    - sources:
      - mod-pagespeed-stable: {{ apache.mod_pagespeed_source }}
  cmd.run:
    - name: a2enmod pagespeed
    - unless: ls {{ apache.moddir }}/pagespeed.load || egrep "^APACHE_MODULES=" /etc/sysconfig/apache2 | grep pagespeed
    - order: 255
    - require:
      - pkg: apache-config-modules-pagespeed-pkg
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

        {%- for dir in ['/var/cache/mod_pagespeed', '/var/log/pagespeed'] %}

apache-config-modules-pagespeed-{{ dir }}-file-directory:
  file.directory:
    - name: {{ dir }}
    - makedirs: true
    - user: {{ apache.user }}
    - group: {{ apache.group }}
    - require:
      - pkg: apache-config-modules-pagespeed-pkg
      - user: {{ apache.user }}
      - group: {{ apache.group }}

        {%- endfor %}
        # Here we hardcode a logrotate entry to take care of the logs

apache-config-modules-pagespeed-logrotate-file-managed:
  file.managed:
    - name: /etc/logrotate.d/pagespeed
    - contents: |
        /var/log/pagespeed/*.log {
          weekly
          missingok
          rotate 52
          compress
          delaycompress
          notifempty
          sharedscripts
          postrotate
            if /etc/init.d/apache2 status > /dev/null ; then \
              /etc/init.d/apache2 reload > /dev/null; \
            fi;
          endscript
        }
    {%- endif %}
