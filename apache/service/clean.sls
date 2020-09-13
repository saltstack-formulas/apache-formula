# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import apache with context %}

apache-service-clean-service-dead:
  service.dead:
    - name: {{ apache.service.name }}
    - enable: False
  file.absent:
    - name: /var/lock/subsys/httpd
