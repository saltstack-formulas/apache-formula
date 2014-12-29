{% if grains['os_family']=="Debian" %}

include:
  - apache

mod-php5:
  pkg.installed:
    - name: libapache2-mod-php5
    - order: 180
    - require:
      - pkg: apache

a2enmod php5:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/php5.load
    - order: 225
    - require:
      - pkg: mod-php5
    - watch_in:
      - module: apache-restart

{% if 'apache' in pillar and 'php-ini' in pillar['apache'] %}
/etc/php5/apache2/php.ini:
  file.managed:
    - source: {{ pillar['apache']['php-ini'] }}
    - order: 225
    - watch_in:
      - module: apache-restart
    - require:
      - pkg: apache
      - pkg: mod-php5
{% endif %}

{% endif %}
