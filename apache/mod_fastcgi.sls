{% from "apache/map.jinja" import apache with context %}

include:
  - apache
  - apache.mod_actions

{% if grains['os_family']=="Debian" %}
mod-fastcgi:
  pkg.installed:
    - name: {{ apache.mod_fastcgi }}
    - order: 180
    - require:
      - pkgrepo: repo-fastcgi
      - pkg: apache

repo-fastcgi:
  pkgrepo.managed:
    - name: "deb http://ftp.us.debian.org/debian {{ grains['oscodename'] }}"
    - file: /etc/apt/sources.list.d/non-free.list
    - onlyif: grep Debian /proc/version >/dev/null 2>&1
    - comps: non-free

a2enmod fastcgi:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/fastcgi.load
    - order: 225
    - require:
      - pkg: mod-fastcgi
    - watch_in:
      - module: apache-restart

{% endif %}

