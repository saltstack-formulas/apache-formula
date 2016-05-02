{% from "apache/map.jinja" import apache with context %}

include:
  - apache
  - apache.config

{{apache.confdir}}/server-status{{apache.confext}}:
  file.managed:
    - source: salt://apache/files/server-status.conf
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart
