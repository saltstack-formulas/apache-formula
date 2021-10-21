# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import apache with context %}

apache-config-logrotate-file-managed:
  file.managed:
    - name: {{ apache.logrotatedir }}
    - makedirs: True
    - contents: {{ apache.logrotatecontents }}
