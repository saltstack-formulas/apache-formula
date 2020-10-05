# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_file = tplroot ~ '.config.file' %}
{%- set sls_config_registersite = tplroot ~ '.config.register_site' %}
{%- from tplroot ~ "/map.jinja" import apache with context %}

include:
  - {{ sls_config_file }}
  - {{ sls_config_registersite }}

apache-service-running:
  {%- if salt['pillar.get']('apache:manage_service_states', True) %}
      {# By default run apache service states (unless pillar is false) #}
  service.running:
    - name: {{ apache.service.name }}
    - enable: True
    - watch:
      - sls: {{ sls_config_file }}
    - retry: {{ apache.retry_option|json }}
  cmd.run:
    - names:
      - journalctl -xe -u {{ apache.service.name }} || tail -20 /var/log/messages || true
      - (service {{ apache.service.name }} restart && service {{ apache.service.name }} status) || true
      - cat {{ apache.config }}
    - onfail:
      - service: apache-service-running
  {%- endif %}

  {# The following states are by default inert and can be used #}
  {# by other states to trigger a restart or reload as needed. #}

apache-service-running-restart:
  module.wait:
         {%- if apache.service_state in ['running'] %}
    - name: service.restart
    - m_name: {{ apache.service.name }}
         {%- else %}
    - name: cmd.run
    - cmd: {{ apache.custom_reload_command|default('apachectl graceful') }}
    - python_shell: True
         {%- endif %}
    - watch:
      - sls: {{ sls_config_file }}
    - require:
      - sls: {{ sls_config_file }}
      - service: apache-service-running

apache-service-running-reload:
  module.wait:
         {%- if apache.service_state in ['running'] %}
    - name: service.reload
    - m_name: {{ apache.service.name }}
         {%- else %}
    - name: cmd.run
    - cmd: {{ apache.custom_reload_command|default('apachectl graceful') }}
    - python_shell: True
         {%- endif %}
    - watch:
      - sls: {{ sls_config_file }}
    - require:
      - sls: {{ sls_config_file }}
      - service: apache-service-running
