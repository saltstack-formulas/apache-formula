{% from "apache/map.jinja" import apache with context %}

{% if grains['os_family']=="FreeBSD" %}

include:
  - apache

{{ apache.modulesdir }}/009_mod_socache_shmcb.conf:
  file.managed:
    - source: salt://apache/files/{{ salt['grains.get']('os_family') }}/generic_module.conf.jinja
    - mode: 644
    - template: jinja
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart
    - context:
      module_name: socache_shmcb

{% endif %}
