{% from "apache/map.jinja" import apache with context %}

include:
  - apache

{% if grains.os_family == 'Debian' %}

{% set dirpath = '/etc/apache2/sites-enabled' %}

{# Add . and .. to make it easier to not clean those #}
{% set valid_sites = ['.', '..', ] %}

{# Take sites from apache.vhosts.standard #}
{% for id, site in salt['pillar.get']('apache:sites', {}).items() %}
{%   do valid_sites.append('{}{}'.format(id, apache.confext)) %}
{% endfor %}

{# Take sites from apache.register_site #}
{% for id, site in salt['pillar.get']('apache:register-site', {}) %}
{%   do valid_sites.append('{}{}'.format(site.name, apache.confext)) %}
{% endfor %}


{% for filename in salt['file.readdir']('/etc/apache2/sites-enabled/') %}
{%   if filename not in valid_sites %}

a2dissite {{ filename }}:
  cmd.run:
    - onlyif: "test -L {{ dirpath}}/{{ filename }} || test -f {{ dirpath}}/{{ filename }}"
    - watch_in:
      - module: apache-reload

{%   endif %}
{% endfor %}


{% endif %}{# Debian #}
