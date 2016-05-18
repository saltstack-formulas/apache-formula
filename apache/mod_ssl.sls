{% if grains['os_family']=="Debian" %}

include:
  - apache

a2enmod mod_ssl:
  cmd.run:
    - name: a2enmod ssl
    - unless: ls /etc/apache2/mods-enabled/ssl.load
    - order: 225
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart

{% elif grains['os_family']=="RedHat" %}

mod_ssl:
  pkg.installed:
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart

{% endif %}
