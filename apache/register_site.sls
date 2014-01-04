{% if grains['os_family']=="Debian" %}

{% if 'apache' in pillar and 'register-site' in pillar['apache'] %} #BEGIN: ['apache']['register-site']
{% for site in pillar['apache']['register-site'] %}

#BEGIN: Call apache a2ensite
##########################################
{% if 'name' in pillar['apache']['register-site'][site] and 'state' in pillar['apache']['register-site'][site] %}

{% if pillar['apache']['register-site'][site]['state'] == 'enabled' %}
a2ensite {{ pillar['apache']['register-site'][site]['name'] }}:
{% else %}
a2dissite {{ pillar['apache']['register-site'][site]['name'] }}:
{% endif %}
  cmd.run:
{% if pillar['apache']['register-site'][site]['state'] == 'enabled' %}
    - unless: ls /etc/apache2/sites-enabled/{{ pillar['apache']['register-site'][site]['name'] }}
{% else %}
    - onlyif: ls /etc/apache2/sites-enabled/{{ pillar['apache']['register-site'][site]['name'] }}
{% endif %}
    - order: 230
    - require:
      - pkg: apache
      - file: /etc/apache2/sites-available/{{ pillar['apache']['register-site'][site]['name'] }}

{% endif %}
##########################################

#BEGIN: Manage apache site config
##########################################
{% if 'name' in pillar['apache']['register-site'][site] and 'path' in pillar['apache']['register-site'][site] %}

/etc/apache2/sites-available/{{ pillar['apache']['register-site'][site]['name'] }}:
  file.managed:
    - source: {{ pillar['apache']['register-site'][site]['path'] }}
    - order: 225
    - user: root
    - group: root
    - mode: 775
    - watch_in:
      - cmd: a2ensite {{ pillar['apache']['register-site'][site]['name'] }}
      - module: apache-reload

{% endif %}
##########################################

{% endfor %}
{% endif %} #END: apache-register-site
{% endif %} #END: grains['os_family'] == debian
