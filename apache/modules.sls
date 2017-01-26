{% if grains['os_family']=="Debian" %}
{%- set module_includes = [
  'dav_svn', 'fcgid', 'mpm', 'pagespeed', 'php5', 'proxy_http', 'proxy',
  'remoteips', 'security', 'ssl', 'wsgi',
] -%}

include:
  - apache
{%- for module in salt['pillar.get']('apache:modules:enabled', []) %}
{%- if module in module_includes %}
  - apache.mod_{{ module }}
{%- endif %}
{%- endfor %}

{%- for module in salt['pillar.get']('apache:modules:enabled', []) %}
{% if module not in module_includes %}
a2enmod {{ module }}:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/{{ module }}.load
    - order: 225
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart
{%- endif %}
{%- endfor %}

{% for module in salt['pillar.get']('apache:modules:disabled', []) %}
a2dismod -f {{ module }}:
  cmd.run:
    - onlyif: ls /etc/apache2/mods-enabled/{{ module }}.load
    - order: 225
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart
{% endfor %}

{% elif grains['os_family']=="RedHat" %}

include:
  - apache
 
{% for module in salt['pillar.get']('apache:modules:enabled', []) %}
find /etc/httpd/ -name '*.conf' -type f -exec sed -i -e 's/\(^#\)\(\s*LoadModule.{{ module }}_module\)/\2/g' {} \;:
  cmd.run:
    - unless: httpd -M 2> /dev/null | grep "[[:space:]]{{ module }}_module"
    - order: 225
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart
{% endfor %}

{% for module in salt['pillar.get']('apache:modules:disabled', []) %}
find /etc/httpd/ -name '*.conf' -type f -exec sed -i -e 's/\(^\s*LoadModule.{{ module }}_module\)/#\1/g' {} \;:
  cmd.run:
    - onlyif: httpd -M 2> /dev/null | grep "[[:space:]]{{ module }}_module"
    - order: 225
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart
{% endfor %}

{% endif %}
