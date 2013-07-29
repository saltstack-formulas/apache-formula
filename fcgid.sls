include:
  - apt

{% if grains['os']=="Ubuntu" %}

mod-fcgid:
  pkg.installed:
    - name: libapache2-mod-fcgid
    - order: 180
    - require:
      - pkg: apache2

a2enmod fcgid:
  cmd.run:
    - order: 225
    - unless: ls /etc/apache2/mods-enabled/fcgid.load
    - require: 
      - pkg: mod-fcgid
    - watch_in:
      - cmd: apache2-restart

{% endif %}
