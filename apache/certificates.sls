{% from "apache/map.jinja" import apache with context %}

include:
  - apache

{%- for site, confcert in salt['pillar.get']('apache:sites', {}).iteritems() %}

{% if confcert.SSLCertificateKeyFile is defined and confcert.SSLCertificateKeyFile_content is defined %}
# Deploy {{ site }} key file
apache_cert_config_{{ site }}_key_file:
  file.managed:
    - name: {{ confcert.SSLCertificateKeyFile }}
    - contents_pillar: apache:sites:{{ site }}:SSLCertificateKeyFile_content
    - makedirs: True
    - mode: 600
    - user: root
    - group: root
    - watch_in:
      - module: apache-reload
{% endif %}

{% if confcert.SSLCertificateFile is defined and confcert.SSLCertificateFile_content is defined %}
# Deploy {{ site }} cert file
apache_cert_config_{{ site }}_cert_file:
  file.managed:
    - name: {{ confcert.SSLCertificateFile }}
    - contents_pillar: apache:sites:{{ site }}:SSLCertificateFile_content
    - makedirs: True
    - mode: 600
    - user: root
    - group: root
    - watch_in:
      - module: apache-reload
{% endif %}

{% if confcert.SSLCertificateChainFile is defined and confcert.SSLCertificateChainFile_content is defined %}
# Deploy {{ site }} bundle file
apache_cert_config_{{ site }}_bundle_file:
  file.managed:
    - name: {{ confcert.SSLCertificateChainFile }}
    - contents_pillar: apache:sites:{{ site }}:SSLCertificateChainFile_content
    - makedirs: True
    - mode: 600
    - user: root
    - group: root
    - watch_in:
      - module: apache-reload
{% endif %}

{%- endfor %}

