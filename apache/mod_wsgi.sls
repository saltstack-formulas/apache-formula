{% from "apache/map.jinja" import apache with context %}

include:
  - apache

mod_wsgi:
  pkg.installed:
    - name: {{ apache.mod_wsgi }}
    - require:
      - pkg: apache

{% if grains.get('os_family') == 'RedHat' and grains.get('osmajorrelease') < 7 %}
/etc/httpd/conf.d/wsgi.conf:
  file.uncomment:
    - regex: LoadModule
    - require:
      - pkg: mod_wsgi
    - watch_in:
      - module: apache-restart
    - require_in:
      - module: apache-restart
      - module: apache-reload
      - service: apache
{% endif %}
