{% if grains['os_family']=="Debian" %}

include:
  - apache

a2enmod actions:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/actions.load
    - order: 255
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart

{% endif %}
