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
  module.wait:
    - name: service.reload {{ apache.service }}

apache-restart:
  module.wait:
    - name: service.restart {{ apache.service }}

