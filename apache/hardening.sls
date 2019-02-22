{% from "apache/map.jinja" import apache with context %}

include:
  - apache

nologin_shell_for_apache_user:
  user.present:
    - name: {{ apache.user }}
    - shell: /sbin/nologin
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart
    - require_in:
      - module: apache-restart
      - module: apache-reload
      - service: apache

remove_httpd_manual:
  pkg.removed:
    - name: httpd-manual
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart
    - require_in:
      - module: apache-restart
      - module: apache-reload
      - service: apache

/etc/httpd/conf.d/autoindex.conf:
  file.managed:
    - contents: |
        # File commented with Salt, Do NOT Edit
        # Do NOT delete because it is contained in the rpm, so it wil re-created on the next upgrade
        # It is emptied for hardening purpose
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart
    - require_in:
      - module: apache-restart
      - module: apache-reload
      - service: apache


/etc/httpd/cgi-bin/printenv:
  file.absent:
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart
    - require_in:
      - module: apache-restart
      - module: apache-reload
      - service: apache

/etc/httpd/cgi-bin/test-cgi:
  file.absent:
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart
    - require_in:
      - module: apache-restart
      - module: apache-reload
      - service: apache
