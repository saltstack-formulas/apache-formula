{% if grains['os_family']=="Debian" %}

include:
  - apache
  - apache.mod_actions

repo-fastcgi:
  pkgrepo.managed:
    - name: "deb http://httpredir.debian.org/debian jessie"
    - file: /etc/apt/sources.list.d/non-free.list
    - comps: non-free

mod-fastcgi:
  pkg.installed:
    - name: {{ apache.mod_fastcgi }}
    - order: 180
    - require:
      - pkg: apache

a2enmod fastcgi:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/fastcgi.load
    - order: 225
    - require:
      - pkgrepo: repo-fastcgi
      - pkg: mod-fastcgi
    - watch_in:
      - module: apache-restart

{% endif %}

