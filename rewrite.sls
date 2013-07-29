include:
  - apt

{% if grains['os']=="Ubuntu" %}

a2enmod rewrite:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/rewrite.load
    - order: 225
    - watch_in:
      - cmd: apache-restart

{% endif %}
