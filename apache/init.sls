{% from "apache/map.jinja" import apache with context %}

apache:
  pkg.installed:
    - name: {{ apache.server }}
  service.{{apache.service_state}}:
    - name: {{ apache.service }}
{% if apache.service_state in [ 'running', 'dead' ] %}
    - enable: {{apache.service_enable}}
{% endif %}

# The following states are inert by default and can be used by other states to
# trigger a restart or reload as needed.
apache-reload:
  module.wait:
{% if apache.service_state in ['running'] %}
    - name: service.reload
    - m_name: {{ apache.service }}
{% else %}
    - name: cmd.run
    - m_name: {{ apache.service }} -k graceful
{% endif %}

apache-restart:
{% if apache.service_state in ['running'] %}
  module.wait:
    - name: service.restart
    - m_name: {{ apache.service }}
{% else %}
# a bit hackish, but reload doesnt start apache when it is not running
# needed when service_state is disabled but apache is controlled by a 
# cluster manager like Pacemaker
  module.wait:
    - name: cmd.run
    - m_name: {{ apache.service }} -k graceful
{% endif %}
