{% if grains['os_family']=="Debian" %}

{% from "apache/map.jinja" import apache with context %}

include:
  - apache

apache_own-default-vhost:
  file.managed:
    - name: {{ apache.vhostdir }}/000-default.conf
    - source: salt://apache/files/{{ salt['grains.get']('os_family') }}/sites-available/000-default.conf
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-reload

{% endif %}
