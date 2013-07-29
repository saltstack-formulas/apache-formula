include:
  - core.apt
  - core.apache2.register_site

{% if grains['os']=="Ubuntu" %}

apache2:
  pkg.installed:
    - name: apache2
    - order: 175
  service.running:
    - enable: True
    - order: 455

a2dissite 000-default:
  cmd.run:
    - order: 225
    - onlyif: ls /etc/apache2/sites-enabled/000-default
    - watch_in:
      - cmd: apache2-reload
    - require:
      - pkg: apache2

apache2-reload:
  cmd.wait:
    - name: service apache2 reload
    - order: 420

apache2-restart:
  cmd.wait:
    - name: service apache2 restart
    - order: 425

/etc/apache2/sites-available/default:
  file.absent:
    - order: 230
    - require:
      - pkg: apache2

/etc/apache2/sites-available/default-ssl:
  file.absent:
    - order: 230
    - require:
      - pkg: apache2

{% endif %} #END: os = ubuntu
