{% if grains['os_family']=="Debian" %}

include:
  - apache

a2enmod mod_proxy:
  cmd.run:
    - name: a2enmod proxy
    - unless: ls /etc/apache2/mods-enabled/proxy.load
    - order: 225
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart

{% endif %}
