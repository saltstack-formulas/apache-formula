{% if grains['os_family']=="Debian" %}

{% from "apache/map.jinja" import apache with context %}

include:
  - apache

a2dissite 000-default.conf:
  cmd.run:
    - unless: test ! -f /etc/apache2/sites-enabled/000-default.conf
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-reload

{% endif %}
