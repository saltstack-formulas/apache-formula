{% from "apache/map.jinja" import apache with context %}

include:
  - apache

mod-perl2:
  pkg.installed:
    - name: {{ apache.mod_perl2 }}
    - order: 180
    - require:
      - pkg: apache

{% if grains['os_family']=="Debian" %}
a2enmod perl2:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/perl2.load
    - order: 225
    - require:
      - pkg: mod-perl2
    - watch_in:
      - module: apache-restart

{% elif grains['os_family']=="FreeBSD" %}

{{ apache.modulesdir }}/260_mod_perl.conf:
  file.managed:
    - source: salt://apache/files/{{ salt['grains.get']('os_family') }}/mod_perl.conf.jinja
    - mode: 644
    - template: jinja
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart

{% endif %}
