{% from "apache/map.jinja" import apache with context %}

nologin_shell_for_apache_user:
  user.present:
    - name: {{ apache.user }}
    - shell: /sbin/nologin
    - require:
      - pkg: apache

remove_httpd_manual:
  pkg.removed:
    - name: httpd-manual
    - require:
      - pkg: apache

/etc/httpd/conf.d/autoindex.conf:
  file.absent:
    - require:
      - pkg: apache


/etc/httpd/cgi-bin/printenv:
  file.absent:
    - require:
      - pkg: apache

/etc/httpd/cgi-bin/test-cgi:
  file.absent:
    - require:
      - pkg: apache
