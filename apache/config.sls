{% from "apache/map.jinja" import apache with context %}

include:
  - apache

{{ apache.configfile }}:
  file.managed:
    - template: jinja
    - source:
      - salt://apache/files/{{ salt['grains.get']('os_family') }}/apache.config.jinja
    - require:
      - pkg: apache
    - watch_in:
      - service: apache

{{ apache.vhostdir }}:
  file.directory:
    - require:
      - pkg: apache
    - watch_in:
      - service: apache

{% if grains['os_family']=="Debian" %}
/etc/apache2/envvars:
  file.managed:
    - template: jinja
    - source:
      - salt://apache/files/Debian/envvars.jinja
    - require:
      - pkg: apache
    - watch_in:
      - service: apache
{% endif %}

{% if grains['os_family']=="RedHat" %}
/etc/httpd/conf.d/welcome.conf:
  file.absent:
    - require:
      - pkg: apache
    - watch_in:
      - service: apache
{% endif %}
