{% if grains['os_family']=="Debian" %}

{% from "apache/map.jinja" import apache with context %}

include:
  - apache

apache_no-default-vhost:
  file.absent:
    - name: {{ apache.vhostdir }}/000-default.conf
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-reload
    - require_in:
      - module: apache-restart
      - module: apache-reload
      - service: apache

{% endif %}
