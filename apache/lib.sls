# macros for conf Files

{%- macro output_indented(mytext, indent_value) %}
{{ mytext | indent(indent_value, true) }}
{%- endmacro %}

{%- macro directives_output(container, col, default_keys = []) -%}
{%- for ordered_directive in container.get('directives', []) -%}
{%- for directive, value in ordered_directive.items() if directive not in default_keys| difference(['LogFormat']) -%}
{{ output_indented(directive + ' ' + value|string, col) }}
{%- endfor %}
{%- endfor %}
{%- endmacro %}

{%- macro container_output(container_name, container_data, col=0, default_directives = []) -%}
{%- set header_text = '<' ~ container_name ~ ' ' ~ container_data.item ~ '>' -%}
{{ output_indented(header_text, col) }}
{{ directives_output(container_data, col+4, default_directives ) }}
{%- for nested_container_name, nested_containers in container_data.get('containers', {}).items() %}
{%- for nested_container in nested_containers %}
{{ container_output(nested_container_name, nested_container, col+4) }}
{%- endfor %}
{%- endfor %}
{%- set footer_text = '</' ~ container_name ~ '>' -%}
{{ output_indented(footer_text, col) }}
{%- endmacro %}
