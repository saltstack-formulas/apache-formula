{% if grains['os_family']=="Debian" %}

include:
  - apache

a2enmod proxy:
  cmd.run:
    - unless: a2query -q -m proxy
    - order: 225
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart

{% endif %}
