{% from "apache/map.jinja" import apache with context %}
{% set restart_command = 

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
    - cmd: {{apache.custom_reload_command|default('apachectl graceful')}}
    - python_shell: True
{% endif %}

apache-restart:
{% if apache.service_state in ['running'] %}
  module.wait:
    - name: service.restart
    - m_name: {{ apache.service }}
{% else %}
  module.wait:
    - name: cmd.run
    - cmd: {{apache.custom_restart_command|default('apachectl restart')}}
    - python_shell: True
{% endif %}
