{% from "apache/map.jinja" import apache with context %}
      
apache-uninstall:
  service.dead:
    - name: {{ apache.service }}
    - enable: False
  pkg.removed:
    - pkgs:
      - {{ apache.server }}
    - require:
      - service: apache-uninstall
