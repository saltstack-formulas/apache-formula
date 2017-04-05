{% from "apache/map.jinja" import apache with context %}

include:
  - apache

mod_wsgi:
  pkg.installed:
    - name: {{ apache.mod_wsgi }}
    - require:
      - pkg: apache

{% if grains.get('os_family') == 'RedHat' %}
/etc/httpd/conf.d/wsgi.conf:
  file.uncomment:
    - regex: LoadModule
    - onlyif: test -f /etc/httpd/conf.d/wsgi.conf
    - require:
      - pkg: mod_wsgi
{% endif %}
