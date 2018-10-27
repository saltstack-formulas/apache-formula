{% from "apache/map.jinja" import apache with context %}

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

/etc/apache2/mods-available/ssl.conf:
  file.managed:
    - source: salt://apache/files/{{ salt['grains.get']('os_family') }}/ssl.conf.jinja
    - template: jinja
    - mode: 644
    - watch_in:
      - module: apache-restart

{% elif grains['os_family']=="RedHat" %}

mod_ssl:
  pkg.installed:
    - name: {{ apache.mod_ssl }}
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart

{{ apache.confdir }}/ssl.conf:
  file.absent:
    - require:
      - pkg: apache
    - watch_in:
      - service: apache

{% elif grains['os_family']=="FreeBSD" %}

include:
  - apache
  - apache.mod_socache_shmcb

{{ apache.modulesdir }}/010_mod_ssl.conf:
  file.managed:
    - source: salt://apache/files/{{ salt['grains.get']('os_family') }}/mod_ssl.conf.jinja
    - mode: 644
    - template: jinja
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart

{% endif %}

{{ apache.confdir }}/tls-defaults.conf:
{% if salt['pillar.get']('apache:mod_ssl:manage_tls_defaults', False) %}
  file.managed:
    - source: salt://apache/files/tls-defaults.conf.jinja
    - mode: 644
    - template: jinja
{% else %}
  file.absent:
{% endif %}
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart

{% if grains['os_family']=="Debian" %}
a2endisconf tls-defaults:
  cmd.run:
{%   if salt['pillar.get']('apache:mod_ssl:manage_tls_defaults', False) %}
    - name: a2enconf tls-defaults
    - unless: test -L /etc/apache2/conf-enabled/tls-defaults.conf
{%   else %}
    - name: a2disconf tls-defaults
    - onlyif: test -L /etc/apache2/conf-enabled/tls-defaults.conf
{%   endif %}
    - order: 225
    - require:
      - pkg: apache
      - file: {{ apache.confdir }}/tls-defaults.conf
    - watch_in:
      - module: apache-restart
{% endif %}
