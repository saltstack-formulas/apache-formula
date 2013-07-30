include:
  - apt
  - apache.register_site

{% if grains['os']=="Ubuntu" %}

apache:
  pkg.installed:
    - name: apache2
    - order: 175
  service.running:
    - name: apache2
    - enable: True
    - order: 455

a2dissite 000-default:
  cmd.run:
    - order: 225
    - onlyif: ls /etc/apache2/sites-enabled/000-default
    - watch_in:
      - cmd: apache-reload
    - require:
      - pkg: apache

apache-reload:
  cmd.wait:
    - name: service apache2 reload
    - order: 420

apache-restart:
  cmd.wait:
    - name: service apache2 restart
    - order: 425

/etc/apache2/sites-available/default:
  file.absent:
    - order: 230
    - require:
      - pkg: apache

/etc/apache2/sites-available/default-ssl:
  file.absent:
    - order: 230
    - require:
      - pkg: apache

{% endif %} #END: os = ubuntu
