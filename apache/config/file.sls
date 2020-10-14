# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_running = tplroot ~ '.service.running' %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import apache with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_service_running }}
  - {{ sls_package_install }}

apache-config-file-directory-logdir:
  file.directory:
    - name: {{ apache.logdir }}
    - user: {{ apache.user }}
    - group: {{ apache.group }}
    - makedirs: True
    - require:
      - sls: {{ sls_package_install }}
    - require_in:
      - service: apache-service-running

apache-config-file-directory-vhostdir:
  file.directory:
    - name: {{ apache.vhostdir }}
    - makedirs: True
    - require:
      - sls: {{ sls_package_install }}
    - require_in:
      - service: apache-service-running

apache-config-file-directory-moddir:
  file.directory:
    - name: {{ apache.moddir }}
    - makedirs: True
    - require:
      - sls: {{ sls_package_install }}
    - require_in:
      - service: apache-service-running

    {%- if apache.davlockdbdir %}

apache-config-file-directory-davlockdbdir:
  file.directory:
    - name: {{ apache.davlockdbdir }}
    - makedirs: True
    - user: {{ apache.user }}
    - group: {{ apache.group }}
    - recurse:
      - user
      - group
    - require:
      - sls: {{ sls_package_install }}
    - require_in:
      - service: apache-service-running

    {%- endif %}
    {%- if 'sitesdir' in apache and apache.sitesdir %}

apache-config-file-directory-sites-enabled:
  file.directory:
    - name: {{ apache.sitesdir }}
    - makedirs: True
    - require:
      - sls: {{ sls_package_install }}
    - require_in:
      - service: apache-service-running

    {%- endif %}
    {%- if grains.os_family in ('Debian',) and 'confdir' in apache and apache.confdir %}

apache-config-file-directory-conf-enabled:
  file.directory:
    - name: {{ apache.confdir }}
    - makedirs: True
    - require:
      - sls: {{ sls_package_install }}
    - require_in:
      - service: apache-service-running

    {%- endif %}

apache-config-file-managed:
  file.managed:
    - name: {{ apache.config }}
    - source: 'salt://apache/files/{{ grains.os_family }}/apache-{{ apache.version }}.config.jinja'
    - mode: 644
    - user: {{ apache.rootuser }}
        {%- if grains.kernel != 'Windows' %}
    - group: {{ apache.rootgroup }}
        {%- endif %}
    - makedirs: True
    - template: {{ apache.get('template_engine', 'jinja') }}
    - require:
      - sls: {{ sls_package_install }}
    - context:
        apache: {{ apache | json }}

  {%- if grains.os_family in ('Debian', 'FreeBSD') %}

apache-config-file-managed-{{ grains.os }}-env:
  file.managed:
    - name: /etc/apache2/envvars
    - source: 'salt://apache/files/{{ grains.os_family }}/envvars-{{ apache.version }}.jinja'
    - mode: 644
    - user: {{ apache.rootuser }}
    - group: {{ apache.rootgroup }}
    - makedirs: True
    - template: {{ apache.get('template_engine', 'jinja') }}
    - context:
      apache: {{ apache | json }}
    - require_in:
      - file: apache-config-file-managed-{{ grains.os }}-ports

apache-config-file-managed-{{ grains.os }}-ports:
  file.managed:
    - name: {{ apache.portsfile }}
    - source: salt://apache/files/{{ grains.os_family }}/ports-{{ apache.version }}.conf.jinja
    - mode: 644
    - user: {{ apache.rootuser }}
    - group: {{ apache.rootgroup }}
    - makedirs: True
    - template: {{ apache.get('template_engine', 'jinja') }}
    - context:
      apache: {{ apache | json }}

  {%- elif grains.os_family == "RedHat" %}

apache-config-file-absent-{{ grains.os }}:
  file.absent:
    - name: {{ apache.confdir }}/welcome.conf

  {%- elif grains.os_family == "Suse" %}

apache-config-file-managed-{{ grains.os }}:
  file.managed:
    - name: /etc/apache2/global.conf
    - source: 'salt://apache/files/Suse/global.config.jinja'
    - mode: 644
    - user: {{ apache.rootuser }}
    - group: {{ apache.rootgroup }}
    - makedirs: True
    - template: {{ apache.get('template_engine', 'jinja') }}
    - context:
      apache: {{ apache | json }}

  {%- else %}

apache-config-file-managed-skip:
  test.show_notification:
    - text: |
        No configuration file to manage

  {%- endif %}
    - require:
      - sls: {{ sls_package_install }}
    - watch_in:
      - module: apache-service-running-restart
    - require_in:
      - module: apache-service-running-restart
      - service: apache-service-running
