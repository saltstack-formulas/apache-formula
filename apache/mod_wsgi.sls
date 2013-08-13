{% set pkg = salt['grains.filter_by']({
  'Debian': {'name': 'libapache2-mod-wsgi'},
  'RedHat': {'name': 'mod_wsgi'},
}) %}

mod_wsgi:
  pkg:
    - installed
    - name: {{ pkg.name }}

{% if grains.get('os_family') == 'RedHat' %}
/etc/httpd/conf.d/wsgi.conf:
  file:
    - uncomment
    - regex: LoadModule
    - require:
      - pkg: mod_wsgi
{% endif %}
