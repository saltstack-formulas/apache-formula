{% if grains['os_family']=="Debian" %}

include:
  - apache

a2enmod remoteip:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/remoteip.load
    - order: 255
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart

/etc/apache2/conf-available/remoteip.conf:
  file.managed:
    - template: jinja
    - source:
      - salt://apache/files/{{ salt['grains.get']('os_family') }}/conf-available/remoteip.conf.jinja
    - require:
      - pkg: apache
    - watch_in:
      - service: apache

{% endif %}
