{% if grains['os_family']=="Debian" %}

include:
  - apache

a2enmod vhost_alias:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/vhost_alias.load
    - order: 225
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart

{% endif %}
