{% if grains['os_family']=="Debian" %}

include:
  - apache

a2enmod rewrite:
  cmd.run:
    - unless: a2query -q -m rewrite
    - order: 225
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart

{% endif %}
