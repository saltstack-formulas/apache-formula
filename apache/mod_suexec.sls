{% from "apache/map.jinja" import apache with context %}

include:
  - apache

{% if grains['os_family']=="FreeBSD" %}

{{ apache.modulesdir }}/040_mod_suexec.conf:
  file.managed:
    - source: salt://apache/files/{{ salt['grains.get']('os_family') }}/mod_suexec.conf.jinja
    - mode: 644
    - template: jinja
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart

{% endif %}
