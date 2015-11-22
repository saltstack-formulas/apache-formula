{% from "apache/map.jinja" import apache with context %}
{% if grains['os_family']=="Debian" %}

{% if 'apache' in pillar and 'register-site' in pillar['apache'] %} #BEGIN: ['apache']['register-site']
{% for site in pillar['apache']['register-site'] %}

#BEGIN: Call apache a2ensite
##########################################
{% if 'name' in pillar['apache']['register-site'][site] and 'state' in pillar['apache']['register-site'][site] %}

{% if pillar['apache']['register-site'][site]['state'] == 'enabled' %}
{% set a2modid = "a2ensite " ~ pillar['apache']['register-site'][site]['name'] ~ apache.confext %}
{% else %}
{% set a2modid = "a2dissite " ~ pillar['apache']['register-site'][site]['name'] ~ apache.confext %}
{% endif %}
{{ a2modid }}:
  cmd.run:
{% if pillar['apache']['register-site'][site]['state'] == 'enabled' %}
    - unless: test -f /etc/apache2/sites-enabled/{{ pillar['apache']['register-site'][site]['name'] }}{{ apache.confext }}
{% else %}
    - onlyif: test -f /etc/apache2/sites-enabled/{{ pillar['apache']['register-site'][site]['name'] }}{{ apache.confext }}
{% endif %}
    - order: 230
    - require:
      - pkg: apache
      - file: /etc/apache2/sites-available/{{ pillar['apache']['register-site'][site]['name'] }}{{ apache.confext }}

{% endif %}
##########################################

#BEGIN: Manage apache site config
##########################################
{% if 'name' in pillar['apache']['register-site'][site] and 'path' in pillar['apache']['register-site'][site] %}

/etc/apache2/sites-available/{{ pillar['apache']['register-site'][site]['name'] }}{{ apache.confext }}:
  file.managed:
    - source: {{ pillar['apache']['register-site'][site]['path'] }}
    - order: 225
    - user: root
    - group: root
    - mode: 775
{% if 'template' in pillar['apache']['register-site'][site] and 'defaults' in pillar['apache']['register-site'][site] %}
    - template: jinja
    - defaults:
    {% for key, value in pillar['apache']['register-site'][site]['defaults'].items() %}
      {{ key }}: {{ value }}
    {% endfor %}
{% endif %}
    - watch_in:
      - cmd: {{ a2modid }}
      - module: apache-reload

{% endif %}
##########################################

{% endfor %}
{% endif %} #END: apache-register-site
{% endif %} #END: grains['os_family'] == debian
