{% from "apache/map.jinja" import apache with context %}

include:
  - apache

mod_wsgi:
  pkg.installed:
    - name: {{ apache.mod_wsgi }}
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart
    - require_in:
      - module: apache-restart
      - module: apache-reload
      - service: apache

{% if 'conf_mod_wsgi' in apache %}
{{ apache.conf_mod_wsgi }}:
  file.uncomment:
    - regex: LoadModule
    - onlyif: test -f {{ apache.conf_mod_wsgi }}
    - require:
      - pkg: mod_wsgi
    - watch_in:
      - module: apache-restart
    - require_in:
      - module: apache-restart
      - module: apache-reload
      - service: apache
{% endif %}
