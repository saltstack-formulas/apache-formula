# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_clean = tplroot ~ '.service.clean' %}
{%- from tplroot ~ "/map.jinja" import apache with context %}

    {%- if grains.os_family == 'Debian' %}

include:
  - {{ sls_service_clean }}

        {%- set dirpath = '/etc/apache2/sites-enabled' %}
        {# Add . and .. to make it easier to not clean those #}
        {%- set valid_sites = ['.', '..', ] %}

        {# Take sites from apache.vhosts.standard #}
        {%- for id, site in salt['pillar.get']('apache:sites', {}).items() %}
            {%- do valid_sites.append('{}{}'.format(id, apache.confext)) %}
        {%- endfor %}

        {# Take sites from apache.register_site #}
        {%- for id, site in salt['pillar.get']('apache:register-site', {}).items() %}
            {%- do valid_sites.append('{}{}'.format(site.name, apache.confext)) %}
        {%- endfor %}

        {%- if salt['file.directory_exists'](dirpath) %}
            {%- for filename in salt['file.readdir'](dirpath) %}
                {%- if filename not in valid_sites %}

apache-config-vhosts-clean-{{ filename }}-cmd-run:
  cmd.run:
    - name: a2dissite {{ filename }} || true
    - onlyif: "test -L {{ dirpath }}/{{ filename }} || test -f {{ dirpath }}/{{ filename }}"
    - require:
      - sls: {{ sls_service_clean }}

                {%- endif %}
            {%- endfor %}
        {%- endif %}
    {%- endif %}{# Debian #}
