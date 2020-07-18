{% from "apache/map.jinja" import apache with context %}

include:
  - apache
  - apache.config

{{ apache.confdir }}/server-status{{ apache.confext }}:
  file.managed:
    - source: salt://apache/files/server-status.conf.jinja
    - template: jinja
    - context:
        apache: {{ apache | json }}
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart
    - require_in:
      - module: apache-restart
      - module: apache-reload
      - service: apache

{%- if grains['os_family'] == "Debian" %}
a2enconf server-status:
  cmd.run:
    - unless: 'test -L /etc/apache2/conf-enabled/server-status.conf'
    - order: 225
    - require:
      - pkg: apache
      - file: {{ apache.confdir }}/server-status.conf
    - watch_in:
      - module: apache-restart
    - require_in:
      - module: apache-restart
      - module: apache-reload
      - service: apache
{% endif %}
