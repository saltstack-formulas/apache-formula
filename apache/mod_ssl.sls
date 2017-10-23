{% from "apache/map.jinja" import apache with context %}

{% if grains['os_family']=="Debian" %}

include:
  - apache

a2enmod mod_ssl:
  cmd.run:
    - name: a2enmod ssl
    - unless: ls /etc/apache2/mods-enabled/ssl.load
    - order: 225
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart

{% elif grains['os_family']=="RedHat" %}

mod_ssl:
  pkg.installed:
    - name: {{ apache.mod_ssl }}
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart

{% elif grains['os_family']=="FreeBSD" %}

include:
  - apache
  - apache.mod_socache_shmcb

{{ apache.modulesdir }}/010_mod_ssl.conf:
  file.managed:
    - source: salt://apache/files/{{ salt['grains.get']('os_family') }}/mod_ssl.conf.jinja
    - mode: 644
    - template: jinja
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart

{% endif %}
