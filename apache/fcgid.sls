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
    - unless: a2query -q -m fcgid
    - require:
      - pkg: mod-fcgid
    - watch_in:
      - module: apache-restart

{% endif %}
