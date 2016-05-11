{% from "apache/map.jinja" import apache with context %}

include:
  - apache

mod-security:
  pkg.installed:
    - name: {{ apache.mod_security.package }}
    - order: 180
    - require:
      - pkg: apache

{% if apache.mod_security.crs_install %}
mod-security-crs:
  pkg.installed:
    - name: {{ apache.mod_security.crs_package }}
    - order: 180
    - require:
      - pkg: mod-security
{% endif %}

{% if apache.mod_security.manage_config %}
mod-security-main-config:
  file.managed:
    - name: {{ apache.mod_security.config_file }}
    - order: 220
    - template: jinja
    - source:
      - {{ 'salt://apache/files/' ~ salt['grains.get']('os_family') ~ '/modsecurity.conf.jinja' }}
    - context: {{ apache.mod_security }}
    - require:
      - pkg: mod-security
    - watch_in:
      - module: apache-reload
{% endif %}

{% if grains['os_family']=="Debian" %}
a2enmod security2:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/security2.load && ls /etc/apache2/mods-enabled/security2.conf
    - order: 225
    - require:
      - pkg: mod-security
    - watch_in:
      - module: apache-restart
{% endif %}
