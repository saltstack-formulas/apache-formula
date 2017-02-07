{% from "apache/map.jinja" import apache with context %}

include:
  - apache

mod-xsendfile:
  pkg.installed:
    - name: {{ apache.mod_xsendfile }}
    - order: 180
    - require:
      - pkg: apache

{% if grains['os_family']=="Debian" %}
a2enmod xsendfile:
  cmd.run:
    - order: 225
    - unless: ls /etc/apache2/mods-enabled/xsendfile.load
    - require:
      - pkg: mod-xsendfile
    - watch_in:
      - module: apache-restart

{% endif %}

