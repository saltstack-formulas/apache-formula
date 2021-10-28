# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import apache with context %}

apache-config-logrotate-file-managed:
  file.managed:
    - name: {{ apache.logrotatedir }}
    - makedirs: True
    {%- if grains.os_family == "RedHat" %}
    - contents: |
        {{ apache.logdir }}/*log {
            missingok
            notifempty
            sharedscripts
            delaycompress
            postrotate
                /bin/systemctl reload {{ apache.service.name }}.service > /dev/null 2>/dev/null || true
            endscript
         }
    {% else %}
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
    {% endif %}
