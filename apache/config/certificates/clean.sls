# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_running = tplroot ~ '.service.running' %}
{%- from tplroot ~ "/map.jinja" import apache with context %}

include:
  - {{ sls_service_running }}

{%- for site, cert in salt['pillar.get']('apache:sites', {}).items() %}

    {%- if cert.SSLCertificateKeyFile is defined %}

apache_cert_config_clean_{{ site }}_key_file:
  file.absent:
    - name: {{ cert.SSLCertificateKeyFile }}
    - watch_in:
      - module: apache-service-running-reload
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

    {%- endif %}
    {%- if cert.SSLCertificateFile is defined %}

apache_cert_config_clean_{{ site }}_cert_file:
  file.absent:
    - name: {{ cert.SSLCertificateFile }}
    - watch_in:
      - module: apache-service-running-reload
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

    {%- endif %}
    {%- if cert.SSLCertificateChainFile is defined %}

apache_cert_config_clean_{{ site }}_bundle_file:
  file.managed:
    - name: {{ cert.SSLCertificateChainFile }}
    - watch_in:
      - module: apache-service-running-reload
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

    {%- endif %}
{%- endfor %}
