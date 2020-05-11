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

{% if grains['os_family']=="Debian" %}
a2endisconf server-status:
  cmd.run:
{%   if apache.get('server_status_require') is defined %}
    - name: a2enconf server-status
    - unless: test -L /etc/apache2/conf-enabled/server-status.conf
{%   else %}
    - name: a2disconf server-status
    - onlyif: test -L /etc/apache2/conf-enabled/server-status.conf
{%   endif %}
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
