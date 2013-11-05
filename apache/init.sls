{% from "apache/map.jinja" import apache with context %}

apache:
  pkg:
    - installed
    - name: {{ apache.server }}
  service:
    - running
    - name: {{ apache.service }}
    - enable: True

apache-reload:
  cmd.wait:
    - name: service apache2 reload

apache-restart:
  cmd.wait:
    - name: service apache2 restart

