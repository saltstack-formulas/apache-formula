{% from "apache/map.jinja" import apache with context %}

{% if 'mod_geoip' in apache %}

include:
  - apache

mod-geoip:
  pkg.installed:
    - pkgs:
      - {{ apache.mod_geoip }}
      - {{ apache.mod_geoip_database }}
    - require:
      - pkg: apache

    - watch_in:
      - module: apache-restart

{% if grains['os_family']=="RedHat" %}
geoip conf:
  file.managed:
    - name: {{ apache.confdir }}/geoip.conf
    - user: root
    - group: root
    - mode: 644
    - source: 
      - salt://apache/files/{{ salt['grains.get']('os_family') }}/geoip.conf

geoip database:
  file.managed:
    - name: /usr/share/GeoIP/GeoIP.dat
    - user: root
    - group: root
    - mode: 644
    - source:
      - salt://apache/files/{{ salt['grains.get']('os_family') }}/GeoIP.dat

{% endif %}
{% endif %}
