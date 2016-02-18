{% from "apache/map.jinja" import apache with context %}

{% if grains['os_family']=="Debian" %}

include:
  - apache
  - apache.register_site

extend:
  apache:
    pkg:
      - order: 175
    service:
      - order: 455
  apache-reload:
    module:
      - order: 420
  apache-restart:
    module:
      - order: 425

a2dissite 000-default{{ apache.confext }}:
  cmd.run:
    - onlyif: test -f /etc/apache2/sites-enabled/000-default{{ apache.confext }}
    - watch_in:
      - module: apache-reload
    - require:
      - pkg: apache

/etc/apache2/sites-available/{{ apache.default_site }}:
  file.absent:
    - require:
      - pkg: apache

/etc/apache2/sites-available/{{ apache.default_site_ssl }}:
  file.absent:
    - require:
      - pkg: apache

{% endif %} #END: os = debian
