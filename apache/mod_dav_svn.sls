{% if grains['os_family'] == "Debian" %}

include:
  - apache

libapache2-mod-svn:
  pkg.installed: []


a2enmod dav_svn:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/dav_svn.load
    - order: 255
    - require:
      - pkg: apache
      - pkg: libapache2-mod-svn
    - watch_in:
      - module: apache-restart

a2enmod authz_svn:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/authz_svn.load
    - order: 255
    - require:
      - pkg: apache
      - pkg: libapache2-mod-svn
    - watch_in:
      - module: apache-restart

{% endif %}
