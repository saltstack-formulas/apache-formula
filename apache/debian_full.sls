{% if grains['os_family']=="Debian" %}

include:
  - apt
  - apache
  - apache.register_site

extend:
  apache:
    pkg:
      - order: 175
    service:
      - order: 455

a2dissite 000-default:
  cmd.run:
    - order: 225
    - onlyif: ls /etc/apache2/sites-enabled/000-default
    - watch_in:
      - cmd: apache-reload
    - require:
      - pkg: apache

extend:
  apache-reload:
    - order: 420

extend:
  apache-restart:
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

{% endif %} #END: os = debian
