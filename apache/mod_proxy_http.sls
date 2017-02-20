{% from "apache/map.jinja" import apache with context %}

include:
  - apache
  - apache.mod_proxy

{% if grains['os_family']=="Debian" %}

a2enmod proxy_http:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/proxy_http.load
    - order: 225
    - require:
      - pkg: apache
      - cmd: a2enmod proxy
    - watch_in:
      - module: apache-restart

{% elif grains['os_family']=="FreeBSD" %}
{{ apache.modulesdir }}/040_mod_proxy_http.conf:
  file.managed:
    - source: salt://apache/files/{{ salt['grains.get']('os_family') }}/mod_proxy_http.conf.jinja
    - mode: 644
    - template: jinja
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart

{% endif %}
