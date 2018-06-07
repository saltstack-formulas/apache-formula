{% from "apache/map.jinja" import apache with context %}

{%- macro security_config(name) %}
{{ name }}:
  file.managed:
    - source:
      - salt://apache/files/{{ salt['grains.get']('os_family') }}/security.conf.jinja
      - salt://apache/files/security.conf.jinja
    - mode: 644
    - template: jinja
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart
{%- endmacro %}

include:
  - apache

{% if grains['os_family']=="Debian" %}

{{ security_config('/etc/apache2/conf-available/security.conf') }}
    - onlyif: test -f '/etc/apache2/conf-available/security.conf'

{% elif grains['os_family']=="FreeBSD" %}
{{ security_config(apache.confdir+'/security.conf') }}
{% endif %}
