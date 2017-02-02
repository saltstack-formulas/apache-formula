{% from "apache/map.jinja" import apache with context %}

include:
  - apache

{% if grains['os_family']=="Debian" %}

{% if salt['file.file_exists' ]('/etc/apache2/conf-available/security.conf') %}
apache_security-block:
  file.blockreplace:
    - name: /etc/apache2/conf-available/security.conf
    - marker_start: "# START managed zone -DO-NOT-EDIT-"
    - marker_end: "# END managed zone --"
    - append_if_not_found: True
    - show_changes: True
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-reload

{% for option, value in salt['pillar.get']('apache:security', {}).items() %}
apache_manage-security-{{ option }}:
  file.accumulated:
    - filename: /etc/apache2/conf-available/security.conf
    - name: apache_manage-security-add-{{ option }}
    - text: "{{ option }} {{ value }}"
    - require_in:
      - file: apache_security-block
{% endfor %}

{% endif %}

{% elif grains['os_family']=="FreeBSD" %}
{{ apache.confdir }}/security.conf:
  file.managed:
    - source: salt://apache/files/{{ salt['grains.get']('os_family') }}/security.conf.jinja
    - mode: 644
    - template: jinja
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart
{% endif %}
