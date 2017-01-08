{% from "apache/map.jinja" import apache with context %}

include:
  - apache

{% if grains['os_family']=="Debian" %}
a2enmod mod_proxy:
  cmd.run:
    - name: a2enmod proxy
    - unless: ls /etc/apache2/mods-enabled/proxy.load
    - order: 225
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart

{% elif grains['os_family']=="FreeBSD" %}
{{ apache.modulesdir }}/040_mod_proxy.conf:
  file.managed:
    - source: salt://apache/files/{{ salt['grains.get']('os_family') }}/mod_proxy.conf.jinja
    - mode: 644
    - template: jinja
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart

{% endif %}
