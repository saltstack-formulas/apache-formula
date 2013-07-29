{% if 'apache2-register-site' in pillar %} #BEGIN: apache2-register-site
{% for site in pillar['apache2-register-site'] %}

#BEGIN: Call apache a2ensite
##########################################
{% if 'name' in pillar['apache2-register-site'][site] and 'state' in pillar['apache2-register-site'][site] %}

{% if pillar['apache2-register-site'][site]['state'] == 'enabled' %}
a2ensite {{ pillar['apache2-register-site'][site]['name'] }}:
{% else %}
a2dissite {{ pillar['apache2-register-site'][site]['name'] }}:
{% endif %}
  cmd.run:
{% if pillar['apache2-register-site'][site]['state'] == 'enabled' %}
    - unless: ls /etc/apache2/sites-enabled/{{ pillar['apache2-register-site'][site]['name'] }}
{% else %}
    - onlyif: ls /etc/apache2/sites-enabled/{{ pillar['apache2-register-site'][site]['name'] }}
{% endif %}
    - order: 230
    - require:
      - pkg: apache2
      - file: /etc/apache2/sites-available/{{ pillar['apache2-register-site'][site]['name'] }}

{% endif %}
##########################################

#BEGIN: Manage apache site config
##########################################
{% if 'name' in pillar['apache2-register-site'][site] and 'path' in pillar['apache2-register-site'][site] %}

/etc/apache2/sites-available/{{ pillar['apache2-register-site'][site]['name'] }}:
  file.managed:
    - source: {{ pillar['apache2-register-site'][site]['path'] }}
    - order: 225
    - user: root
    - group: root
    - mode: 775
    - watch_in:
      - cmd: a2ensite {{ pillar['apache2-register-site'][site]['name'] }}
      - cmd: apache2-reload

{% endif %}
##########################################

{% endfor %}
{% endif %} #END: apache2-register-site
