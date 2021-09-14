# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_clean = tplroot ~ '.service.clean' %}
{%- from tplroot ~ "/map.jinja" import apache with context %}

include:
  - {{ sls_service_clean }}

{%- for site, cert in salt['pillar.get']('apache:sites', {}).items() %}

    {%- if cert.SSLCertificateKeyFile is defined %}

apache_cert_config_clean_{{ site }}_key_file:
  file.absent:
    - name: {{ cert.SSLCertificateKeyFile }}
    - require:
      - sls: {{ sls_service_clean }}

    {%- endif %}
    {%- if cert.SSLCertificateFile is defined %}

apache_cert_config_clean_{{ site }}_cert_file:
  file.absent:
    - name: {{ cert.SSLCertificateFile }}
    - require:
      - sls: {{ sls_service_clean }}

    {%- endif %}
    {%- if cert.SSLCertificateChainFile is defined %}

apache_cert_config_clean_{{ site }}_bundle_file:
  file.absent:
    - name: {{ cert.SSLCertificateChainFile }}
    - require:
      - sls: {{ sls_service_clean }}

    {%- endif %}
{%- endfor %}
