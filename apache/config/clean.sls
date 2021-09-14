# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_clean = tplroot ~ '.service.clean' %}
{%- set sls_modules_clean = tplroot ~ '.config.modules.clean' %}
{%- from tplroot ~ "/map.jinja" import apache with context %}

include:
  - .modules.clean
  - {{ sls_service_clean }}

apache-config-clean-file-absent:
  file.absent:
    - names:
      - {{ apache.config }}
      - {{ apache.logdir }}
      - {{ apache.vhostdir }}
      # apache.portsfile
      - /etc/apache2
      - /etc/httpd
      - {{ apache.confdir }}/server-status{{ apache.confext }}
    - require:
      - sls: {{ sls_service_clean }}
      - sls: {{ sls_modules_clean }}
