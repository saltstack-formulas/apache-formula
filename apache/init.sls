apache2:
{% if grains['os_family'] == 'Debian' %}
  pkg:
    - installed
{% endif %}
  service:
    - running
    - endable: True
    - require:
      - pkg: apache2
