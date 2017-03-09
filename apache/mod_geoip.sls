{% from "apache/map.jinja" import apache with context %}

{% if grains['os_family']=="RedHat" %}

include:
  - apache

mod-geoip:
  pkg.installed:
    - pkgs:
      - GeoIP
      - mod_geoip
    - require:
      - pkg: apache

    - watch_in:
      - module: apache-restart

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

