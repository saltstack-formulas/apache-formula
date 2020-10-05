# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.config.clean' %}
{%- from tplroot ~ "/map.jinja" import apache with context %}

include:
  - {{ sls_config_clean }}

apache-package-clean-pkg-removed:
      {%- if grains.os_family == 'Windows' %}
  chocolatey.uninstalled:
    - name: {{ apache.pkg.name }}
      {%- else %}
  pkg.removed:
    - names:
      - {{ apache.pkg.name }}
      - httpd-tools
      {%- endif %}
    - require:
      - sls: {{ sls_config_clean }}
  user.absent:
    - name: {{ apache.user }}
  group.absent:
    - name: {{ apache.group }}
