# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- set sls_service_running = tplroot ~ '.service.running' %}
{%- from tplroot ~ "/map.jinja" import apache with context %}

{%- if grains.os_family == "Debian" %}

include:
  - {{ sls_package_install }}
  - {{ sls_service_running }}

apache-config-register-site-file-directory:
  file.directory:
    - name: {{ apache.sitesdir }}
    - require:
      - pkg: apache-package-install-pkg-installed

    {%- if 'apache' in pillar and 'register-site' in pillar['apache'] %}
        {%- for site in pillar['apache']['register-site'] %}
            {%- if 'name' in pillar['apache']['register-site'][site] and 'state' in pillar['apache']['register-site'][site] %}
                {%- if 'path' in pillar['apache']['register-site'][site] %}
                    {%- if pillar['apache']['register-site'][site]['state'] == 'enabled' %}
                        {%- set a2modid = "a2ensite " ~ pillar['apache']['register-site'][site]['name'] ~ apache.confext %}
                    {%- else %}
                        {%- set a2modid = "a2dissite " ~ pillar['apache']['register-site'][site]['name'] ~ apache.confext %}
                    {%- endif %}

apache-config-register-site-{{ a2modid }}:
  cmd.run:
    - name: {{ a2modid }}
                {%- if pillar['apache']['register-site'][site]['state'] == 'enabled' %}
    - unless: test -f /etc/apache2/sites-enabled/{{ pillar['apache']['register-site'][site]['name'] }}{{ apache.confext }}
                {%- else %}
    - onlyif: test -f /etc/apache2/sites-enabled/{{ pillar['apache']['register-site'][site]['name'] }}{{ apache.confext }}
                {%- endif %}
    - order: 230
    - require:
      - pkg: apache-package-install-pkg-installed
      - file: apache-config-register-site-file-managed
      - file: apache-config-register-site-file-directory
    - watch:
      - file: apache-config-register-site-file-managed

apache-config-register-site-file-managed:
  file.managed:
    - name: /etc/apache2/sites-available/{{ pillar['apache']['register-site'][site]['name'] }}{{ apache.confext }}
    - source: {{ pillar['apache']['register-site'][site]['path'] }}
    - order: 225
    - makedirs: True
    - user: {{ apache.rootuser }}
    - group: {{ apache.rootgroup }}
    - mode: 775
                     {%- if 'template' in pillar['apache']['register-site'][site] and 'defaults' in pillar['apache']['register-site'][site] %}
    - template: {{ apache.get('template_engine', 'jinja') }}
    - defaults:
                         {%- for key, value in pillar['apache']['register-site'][site]['defaults'].items() %}
      {{ key }}: {{ value }}
                         {%- endfor %}
                     {%- endif %}
    - watch_in:
      - module: apache-service-running-reload
    - require_in:
      - module: apache-service-running-reload
  cmd.run:
    - name: echo dummy state to workaround requisite issue >/dev/null 2>&1
    - require_in:
      - file: apache-config-register-site-file-managed

                {%- endif %}
             {%- endif %}
        {%- endfor %}
    {%- endif %} #END: apache-service-running-register-site
{%- endif %} #END: grains['os_family'] == debian
