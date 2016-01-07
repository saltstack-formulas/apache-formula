{% from "apache/map.jinja" import apache with context %}

{{ apache.logrotatedir }}:
  file:
    - managed
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
                        if /etc/init.d/{{ apache.service }} status > /dev/null ; then \
                            /etc/init.d/{{ apache.service }} reload > /dev/null; \
                        fi;
        	endscript
        	prerotate
        		if [ -d /etc/logrotate.d/httpd-prerotate ]; then \
        			run-parts /etc/logrotate.d/httpd-prerotate; \
        		fi; \
        	endscript
        }
