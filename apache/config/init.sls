# -*- coding: utf-8 -*-
# vim: ft=sls

include:
  - .file
  # .modules.clean  # disable (exclude from init state)
  # .modules        # enable by default (read pillars)
  # .debian_full
  - .flags
  - .logrotate
  - .manage_security
  - .no_default_vhost
  # .own_default_vhost
  - .register_site
  - .vhosts
