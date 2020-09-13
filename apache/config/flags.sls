# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_running = tplroot ~ '.service.running' %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import apache with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

    {%- if grains.os_family == 'Suse' %}

include:
  - {{ sls_package_install }}
  - {{ sls_service_running }}

       {%- for flag in salt['pillar.get']('apache:flags:enabled', []) %}

apache-config-flags-{{ flag }}-cmd-a2en:
  cmd.run:
    - name: a2enflag {{ flag }}
    - unless: egrep "^APACHE_SERVER_FLAGS=" /etc/sysconfig/apache2 |grep {{ flag }}
    - require:
      - pkg: apache-package-install-pkg-installed
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running

       {%- endfor %}
       {%- for flag in salt['pillar.get']('apache:flags:disabled', []) %}

apache-config-flags-{{ flag }}-a2dis:
  cmd.run:
    - name: a2disflag -f {{ flag }}
    - onlyif: egrep "^APACHE_SERVER_FLAGS=" /etc/sysconfig/apache2 | grep {{ flag }}
    - require:
      - pkg: apache-package-install-pkg-installed
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - module: apache-service-running-reload
      - service: apache-service-running
        {%- endfor %}

    {%- endif %}
