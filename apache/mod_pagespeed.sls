{% if grains['os_family']=="Debian" %}
{% from "apache/map.jinja" import apache with context %}

include:
  - apache

libapache2-mod-pagespeed:
  pkg:
    - installed
    - sources:
      - mod-pagespeed-stable: https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_amd64.deb


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
    - user: {{ salt['pillar.get']('apache:user', 'www-data') }}
    - group: {{ salt['pillar.get']('apache:group', 'www-data') }}
    - require:
      - pkg: libapache2-mod-pagespeed
      - user: {{ salt['pillar.get']('apache:user', 'www-data') }}
      - group: {{ salt['pillar.get']('apache:group', 'www-data') }}
{% endfor %}

# Here we hardcode a logrotate entry to take care of the logs
/etc/logrorate.d/pagespeed:
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
