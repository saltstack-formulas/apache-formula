{% from "apache/map.jinja" import apache with context %}

include:
  - apache

mod_wsgi:
  pkg.installed:
    - name: {{ apache.mod_wsgi }}
    - require:
      - pkg: apache

{% if apache.conf_mod_wsgi %}
{{ apache.conf_mod_wsgi }}:
  file.uncomment:
    - regex: LoadModule
    - onlyif: test -f {{ apache.conf_mod_wsgi }}
    - require:
      - pkg: mod_wsgi
{% endif %}
