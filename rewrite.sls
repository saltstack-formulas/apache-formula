include:
  - core.apt

{% if grains['os']=="Ubuntu" %}

a2enmod rewrite:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/rewrite.load
    - watch_in:
      - cmd: apache2-restart

{% endif %}
