# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_running = tplroot ~ '.service.running' %}
{%- set sls_config_file = tplroot ~ '.config.file' %}
{%- from tplroot ~ "/map.jinja" import apache with context %}

include:
  - {{ sls_service_running }}
  - {{ sls_config_file }}

    {% set existing_states = salt['cp.list_states']() %}
    {% for module in salt['pillar.get']('apache:modules:enabled', []) %}
apache-config-modules-{{ module }}-enable:

        {% if grains['os_family']=="Debian" %}

  cmd.run:
    - name: a2enmod -f {{ module }}
    - unless: ls {{ apache.moddir }}/{{ module }}.load

        {% elif grains.os_family in ('RedHat', 'Arch') %}

  cmd.run:
    - name: find /etc/httpd/ -name '*.conf' -type f -exec sed -i -e 's/\(^#\)\(\s*LoadModule.{{ module }}_module\)/\2/g' {} \;
    - onlyif: {{ grains.os_family in ('Arch',) and 'true' }} || (httpd -M 2> /dev/null |grep "[[:space:]]{{ module }}_module")

        {% elif salt['grains.get']('os_family') == 'Suse' %}

  cmd.run:
    - name: a2enmod {{ module }}
    - onlyif: egrep "^APACHE_MODULES=" /etc/sysconfig/apache2 |grep {{ module }}

        {% else %}

  test.show_notification:
    - text: |
        No {{ module }} module change

        {%- endif %}
    - order: 225
    - require:
      - sls: {{ sls_config_file }}
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload

    {%- endfor %}
