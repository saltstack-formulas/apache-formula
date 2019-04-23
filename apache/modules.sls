{%- import_yaml "apache/hardening-values.yaml" as hardening_values %}

{% if grains['os_family']=="Debian" %}

include:
  - apache

{% for module in salt['pillar.get']('apache:modules:enabled', []) %}
a2enmod {{ module }}:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/{{ module }}.load
    - order: 225
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart
{% endfor %}

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
  - apache.config
  - apache.vhosts.vhost

{% set modules_enabled = salt['pillar.get']('apache:modules:enabled', default=hardening_values.modules.enforce_enabled, merge=True) %}
{% set conf_files = salt['file.find'](path='/etc/httpd/', type='f', name='*.conf') %}

{% for module in modules_enabled if module not in hardening_values.modules.enforce_disabled %}

{% for conf_file in conf_files if salt['file.search'](path=conf_file, pattern='LoadModule.' ~ module ) %}

enable_{{ module }}_{{ conf_file }}:
  file.uncomment:
    - name: {{ conf_file }}
    - regex: LoadModule.{{ module }}
    - require:
      - pkg: apache
      - sls: apache.config
      - sls: apache.vhosts.vhost
    - watch_in:
      - module: apache-restart

{% endfor %}
{% endfor %}

{% set modules_disabled = salt['pillar.get']('apache:modules:disabled', default=hardening_values.modules.enforce_disabled, merge=True) %}

{% for module in modules_disabled if module not in hardening_values.modules.enforce_enabled %}
{% for conf_file in conf_files if salt['file.search'](path=conf_file, pattern='LoadModule.' ~ module ) %}

disable_{{ module }}_{{ conf_file }}:
  file.comment:
    - name: {{ conf_file }}
    - regex: LoadModule.{{ module }}
    - require:
      - pkg: apache
      - sls: apache.config
      - sls: apache.vhosts.vhost
    - watch_in:
      - module: apache-restart

{% endfor %}
{% endfor %}



{% elif salt['grains.get']('os_family') == 'Suse' or salt['grains.get']('os') == 'SUSE' %}

include:
  - apache

{% for module in salt['pillar.get']('apache:modules:enabled', []) %}
a2enmod {{ module }}:
  cmd.run:
    - unless: egrep "^APACHE_MODULES=" /etc/sysconfig/apache2 | grep {{ module }}
    - order: 225
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart
{% endfor %}

{% for module in salt['pillar.get']('apache:modules:disabled', []) %}
a2dismod -f {{ module }}:
  cmd.run:
    - onlyif: egrep "^APACHE_MODULES=" /etc/sysconfig/apache2 | grep {{ module }}
    - order: 225
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart
{% endfor %}

{% endif %}
