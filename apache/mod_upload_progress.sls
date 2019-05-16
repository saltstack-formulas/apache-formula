{% from "apache/map.jinja" import apache with context %}

{% if grains['os_family']=="Debian" %}
include:
  - apache

libapache2-mod-upload-progress:
  pkg.installed

a2enmod upload_progress:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/upload_progress.load
    - order: 255
    - require:
      - pkg: libapache2-mod-upload-progress
    - watch_in:
      - module: apache-restart
    - require_in:
      - module: apache-restart
      - module: apache-reload
      - service: apache
{% endif %}
