{% from "apache/map.jinja" import apache with context %}

include:
  - apache

libapache2-mod-pagespeed:
  pkg:
    - installed
    - sources:
      - mod-pagespeed-stable: {{ apache.mod_pagespeed_source }}

{% if grains['os_family']=="Debian" %}
a2enmod pagespeed:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/pagespeed.load
    - order: 255
    - require:
      - pkg: libapache2-mod-pagespeed
    - watch_in:
      - service: apache

{% for dir in ['/var/cache/mod_pagespeed', '/var/log/pagespeed'] %}
{{ dir }}:
  file:
    - directory
    - makedirs: true
    - user: {{ apache.user }}
    - group: {{ apache.group }}
    - require:
      - pkg: libapache2-mod-pagespeed
      - user: {{ apache.user }}
      - group: {{ apache.group }}
{% endfor %}

# Here we hardcode a logrotate entry to take care of the logs
/etc/logrotate.d/pagespeed:
  file:
    - managed
    - contents: |
        /var/log/pagespeed/*.log {
          weekly
          missingok
          rotate 52
          compress
          delaycompress
          notifempty
          sharedscripts
          postrotate
            if /etc/init.d/apache2 status > /dev/null ; then \
              /etc/init.d/apache2 reload > /dev/null; \
            fi;
          endscript
        }
{% endif %}
