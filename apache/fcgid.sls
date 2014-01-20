{% if grains['os_family']=="Debian" %}

include:
  - apache

mod-fcgid:
  pkg.installed:
    - name: libapache2-mod-fcgid
    - order: 180
    - require:
      - pkg: apache

a2enmod fcgid:
  cmd.run:
    - order: 225
    - unless: ls /etc/apache2/mods-enabled/fcgid.load
    - require:
      - pkg: mod-fcgid
    - watch_in:
      - module: apache-restart

{% endif %}
