{% if grains['os_family']=="Debian" %}

include:
  - apache
  - apache.mod_proxy

a2enmod proxy_http:
  cmd.run:
    - unless: a2query -q -m proxy_http
    - order: 225
    - require:
      - pkg: apache
      - cmd: a2enmod proxy
    - watch_in:
      - module: apache-restart

{% endif %}
