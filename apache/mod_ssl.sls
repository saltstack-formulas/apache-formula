
include:
  - apache

{% if grains['os_family']=="RedHat" %}
pkg_mod_ssl:
  pkg.installed:
    - name: mod_ssl
    - watch_in:
      - module: apache-reload
    - require_in:
      - module: apache-restart
      - module: apache-reload
      - service: apache
file_mod_ssl:
  file.managed:
    - name: /etc/httpd/conf.d/ssl.conf
    - source: salt://apache/files/RedHat/ssl.conf.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - watch_in:
      - module: apache-reload
    - require_in:
      - module: apache-restart
      - module: apache-reload
      - service: apache

{% endif %}
{% if grains['os_family']=="Debian" %}
a2enmod mod_ssl:
  cmd.run:
    - name: a2enmod ssl
    - unless: ls /etc/apache2/mods-enabled/ssl.load
    - order: 225
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart
    - require_in:
      - module: apache-restart
      - module: apache-reload
      - service: apache

{% endif %}
