{% from "apache/map.jinja" import apache with context %}

{% if salt['grains.get']('os_family') == 'Suse' or salt['grains.get']('os') == 'SUSE' %}

include:
  - apache
 
{% for flag in salt['pillar.get']('apache:flags:enabled', []) %}
a2enflag {{ flag }}:
  cmd.run:
    - unless: egrep "^APACHE_SERVER_FLAGS=" /etc/sysconfig/apache2 | grep {{ flag }}
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart
{% endfor %}

{% for module in salt['pillar.get']('apache:flags:disabled', []) %}
a2disflag -f {{ flag }}:
  cmd.run:
    - onlyif: egrep "^APACHE_SERVER_FLAGS=" /etc/sysconfig/apache2 | grep {{ flag }}
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart
{% endfor %}

{% endif %}
