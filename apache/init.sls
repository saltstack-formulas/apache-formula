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
    - name: service.reload
    - m_name: {{ apache.service }}

apache-restart:
  module.wait:
    - name: service.restart
    - m_name: {{ apache.service }}

{{ apache.home }}:
    file.directory:
        - user: root
        - group: root
        - dir_mode: 755
        - recurse:
            - user
            - group
            - mode
