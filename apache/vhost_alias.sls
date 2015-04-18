{% if grains['os_family']=="Debian" %}

include:
  - apache

a2enmod vhost_alias:
  cmd.run:
    - unless: a2query -q -m vhost_alias
    - order: 225
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart

{% endif %}
