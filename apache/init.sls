{% set pkg = salt['grains.filter_by']({
  'Debian': {'name': 'apache2'},
  'RedHat': {'name': 'httpd'},
}) %}

apache:
  pkg:
    - installed
    - name: {{ pkg.name }}
  service:
    - running
    - name: {{ pkg.name }}
    - enable: True
