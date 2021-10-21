# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import apache with context %}

apache-config-logrotate-file-managed:
  file.managed:
    - name: {{ apache.logrotatedir }}
    - makedirs: True
    - contents: |
        {{ apache.logdir }}/*.log {
                daily
                missingok
                rotate 14
                compress
                delaycompress
                notifempty
                create 640 root adm
                sharedscripts
                postrotate
                    if /etc/init.d/{{ apache.service.name }} status >/dev/null; then \
                        /etc/init.d/{{ apache.service.name }} reload >/dev/null; \
                    fi;
                endscript
                prerotate
                    if [ -d /etc/logrotate.d/httpd-prerotate ]; then \
                       run-parts /etc/logrotate.d/httpd-prerotate; \
                    fi; \
                endscript
        }
