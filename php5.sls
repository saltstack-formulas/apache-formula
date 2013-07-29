include:
  - apt

{% if grains['os']=="Ubuntu" %}

mod-php5:
  pkg.installed:
    - name: libapache2-mod-php5
    - order: 180
    - require:
      - pkg: apache2

a2enmod php5:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/php5.load
    - require:
      - pkg: mod-php5
    - watch_in:
      - cmd: apache2-restart

{% if 'apache2-php-ini' in pillar %}
/etc/php5/apache2/php.ini:
  file.managed:
    - source: {{ pillar['apache2-php-ini'] }}
    - order: 225
    - watch_in:
      - cmd: apache2-restart
    - require:
      - pkg: apache2
      - pkg: php5
{% endif %}

{% endif %}
