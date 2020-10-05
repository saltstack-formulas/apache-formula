# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_clean = tplroot ~ '.service.clean' %}
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
      - /etc/apache2/envvars
      # apache.portsfile
      - /etc/apache2/global.conf
      - /etc/httpd/conf.modules.d
      - /etc/httpd/sites-enabled
      - /etc/httpd/var
      - {{ apache.confdir }}/server-status{{ apache.confext }}
    - require:
      - sls: {{ sls_service_clean }}
