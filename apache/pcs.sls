# -*- coding: utf-8 -*-
# vim: ft=sls

#FIXME
{# from "apache/map.jinja" import apache with context #}

{% set apache = salt['pillar.get']('apache:lookup:pcs', {}) %}

{% if apache.apache_cib is defined and apache.apache_cib %}
apache_pcs__cib_present_{{apache.apache_cib}}:
  pcs.cib_present:
    - cibname: {{apache.apache_cib}}
{% endif %}

{% if 'resources' in apache %}
{% for resource, resource_data in apache.resources.items()|sort %}
apache_pcs__resource_present_{{resource}}:
  pcs.resource_present:
    - resource_id: {{resource}}
    - resource_type: "{{resource_data.resource_type}}"
    - resource_options: {{resource_data.resource_options|json}}
{% if apache.apache_cib is defined and apache.apache_cib %}
    - require:
      - pcs: apache_pcs__cib_present_{{apache.apache_cib}}
    - require_in:
      - pcs: apache_pcs__cib_pushed_{{apache.apache_cib}}
    - cibname: {{apache.apache_cib}}
{% endif %}
{% endfor %}
{% endif %}

{% if 'constraints' in apache %}
{% for constraint, constraint_data in apache.constraints.items()|sort %}
apache_pcs__constraint_present_{{constraint}}:
  pcs.constraint_present:
    - constraint_id: {{constraint}}
    - constraint_type: "{{constraint_data.constraint_type}}"
    - constraint_options: {{constraint_data.constraint_options|json}}
{% if apache.apache_cib is defined and apache.apache_cib %}
    - require:
      - pcs: apache_pcs__cib_present_{{apache.apache_cib}}
    - require_in:
      - pcs: apache_pcs__cib_pushed_{{apache.apache_cib}}
    - cibname: {{apache.apache_cib}}
{% endif %}
{% endfor %}
{% endif %}

{% if apache.apache_cib is defined and apache.apache_cib %}
apache_pcs__cib_pushed_{{apache.apache_cib}}:
  pcs.cib_pushed:
    - cibname: {{apache.apache_cib}}
{% endif %}

apache_pcs__empty_sls_prevent_error:
  cmd.run:
    - name: true
    - unless: true
