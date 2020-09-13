# -*- coding: utf-8 -*-
# vim: ft=sls

include:
  - .install
  - .mod_rewrite
  - .mod_proxy
  - .mod_headers
  {%- if 'osfinger' in grains and grains.osfinger not in ('Amazon Linux-2',) %}
  - .mod_geoip
  {%- endif %}
