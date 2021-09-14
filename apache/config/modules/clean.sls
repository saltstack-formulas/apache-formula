# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_clean = tplroot ~ '.package.clean' %}
{%- set sls_service_clean = tplroot ~ '.service.clean' %}
{%- from tplroot ~ "/map.jinja" import apache with context %}

include:
  - {{ sls_service_clean }}

    {%- set existing_states = salt['cp.list_states']() %}
    {%- for module in salt['pillar.get']('apache:modules:disabled', []) %}
apache-config-modules-{{ module }}-disable:

        {%- if grains['os_family']=="Debian" %}

  cmd.run:
    - name: a2dismod -f {{ module }}
    - onlyif: ls {{ apache.moddir }}/{{ module }}.load

        {%- elif grains.os_family in ('Redhat', 'Arch') %}

  cmd.run:
    - name: find /etc/httpd/ -name '*.conf' -type f -exec sed -i -e 's/\(^\s*LoadModule.{{ module }}_module\)/#\1/g' {} \;
    - onlyif:
      - test -d /etc/httpd
      - {{ grains.os_family in ('Arch',) and 'true' }} || (httpd -M 2> /dev/null |grep "[[:space:]]{{ module }}_module")
  file.absent:
    - name: /etc/httpd/conf.modules.d/*{{ module }}.conf

        {%- elif salt['grains.get']('os_family') == 'Suse' %}

  cmd.run:
    - name: a2dismod {{ module }}
    - onlyif: egrep "^APACHE_MODULES=" /etc/sysconfig/apache2 | grep {{ module }}

        {%- else %}

  test.show_notification:
    - text: |
        No {{ module }} module change

        {%- endif %}

    - order: 225
    - require:
      - sls: {{ sls_service_clean }}

    {%- endfor %}
