{% from "apache/map.jinja" import apache with context %}

include:
  - apache

mod-fcgid:
  pkg.installed:
    - name: {{ apache.mod_fcgid }}
    - order: 180
    - require:
      - pkg: apache

{% if grains['os_family']=="Debian" %}
a2enmod fcgid:
  cmd.run:
    - order: 225
    - unless: ls /etc/apache2/mods-enabled/fcgid.load
    - require:
      - pkg: mod-fcgid
    - watch_in:
      - module: apache-restart

{% endif %}
