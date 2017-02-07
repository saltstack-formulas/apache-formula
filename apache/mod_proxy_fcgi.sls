{% if grains['os_family']=="Debian" %}

include:
  - apache
  - apache.mod_proxy

a2enmod proxy_fcgi:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/proxy_fcgi.load
    - order: 225
    - require:
      - pkg: apache
      - cmd: a2enmod proxy
    - watch_in:
      - module: apache-restart

{% endif %}
