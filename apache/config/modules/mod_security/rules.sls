{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import apache with context %}
{#- set apache = pillar.get('apache', {}) #}
{%- set mod_security = apache.get('mod_security', {}) %}
{%- if mod_security.get('manage_config', False) %}

include:
  - apache.config.modules.mod_security

{%- for rule_name, rule_details in mod_security.get('rules', {}).items() %}
  {%- set rule_set = rule_details.get('rule_set', '') %}
  {%- set enabled = rule_details.get('enabled', False ) %}
  {%- if enabled %}
/etc/modsecurity/{{ rule_name }}:
  file.symlink:
    - target: /usr/share/modsecurity-crs/{{ rule_set }}/{{ rule_name }}
    - user: {{ apache.rootuser }}
    - group: {{ apache.rootgroup }}
    - mode: 755
  {%- else %}
/etc/modsecurity/{{ rule_name }}:
  file.absent:
    - name: /etc/modsecurity/{{ rule_name }}
  {%- endif %}

{%- endfor %}

{%- for custom_rule, custom_rule_details in mod_security.get('custom_rule_files', {}).items() %}
  {%- set file = custom_rule_details.get('file', None) %}
  {%- set path = custom_rule_details.get('path', None) %}
  {%- set enabled = custom_rule_details.get('enabled', False ) %}

  {%- if enabled %}
/etc/modsecurity/{{ file }}:
  file.managed:
    - source: {{ path }}
    - user: {{ apache.rootuser }}
    - group: {{ apache.rootgroup }}
    - mode: 755
    - makedirs: True
  {%- else %}
/etc/modsecurity/{{ file }}:
  file.absent:
    - name: /etc/modsecurity/{{ file }}
  {%- endif %}
{%- endfor %}

{%- endif %}
