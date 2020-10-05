# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_running = tplroot ~ '.service.running' %}
{%- from tplroot ~ "/map.jinja" import apache with context %}

include:
  - {{ sls_service_running }}

{%- for site, cert in salt['pillar.get']('apache:sites', {}).items() %}

    {%- if cert.SSLCertificateKeyFile is defined and cert.SSLCertificateKeyFile_content is defined %}

apache_cert_config_install_{{ site }}_key_file:
  file.managed:
    - name: {{ cert.SSLCertificateKeyFile }}
    - contents_pillar: apache:sites:{{ site }}:SSLCertificateKeyFile_content
    - makedirs: True
    - mode: 600
    - user: {{ apache.rootuser }}
    - group: {{ apache.rootgroup }}
    - watch_in:
      - module: apache-service-running-reload
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

    {%- endif %}
    {%- if cert.SSLCertificateFile is defined and cert.SSLCertificateFile_content is defined %}

apache_cert_config_install_{{ site }}_cert_file:
  file.managed:
    - name: {{ cert.SSLCertificateFile }}
    - contents_pillar: apache:sites:{{ site }}:SSLCertificateFile_content
    - makedirs: True
    - mode: 600
    - user: {{ apache.rootuser }}
    - group: {{ apache.rootgroup }}
    - watch_in:
      - module: apache-service-running-reload
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

    {%- endif %}
    {%- if cert.SSLCertificateChainFile is defined and cert.SSLCertificateChainFile_content is defined %}

apache_cert_config_install_{{ site }}_bundle_file:
  file.managed:
    - name: {{ cert.SSLCertificateChainFile }}
    - contents_pillar: apache:sites:{{ site }}:SSLCertificateChainFile_content
    - makedirs: True
    - mode: 600
    - user: {{ apache.rootuser }}
    - group: {{ apache.rootgroup }}
    - watch_in:
      - module: apache-service-running-reload
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

    {%- endif %}
{%- endfor %}
