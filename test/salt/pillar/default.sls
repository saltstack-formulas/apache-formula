# -*- coding: utf-8 -*-
# vim: ft=yaml
---
apache:
  manage_service_states: False
  mod_security:
    crs_install: True
    manage_config: True
    sec_rule_engine: 'On'
    sec_request_body_access: 'On'
    sec_request_body_limit: '14000000'
    sec_request_body_no_files_limit: '114002'
    sec_request_body_in_memory_limit: '114002'
    sec_request_body_limit_action: 'Reject'
    sec_pcre_match_limit: '15000'
    sec_pcre_match_limit_recursion: '15000'
    sec_debug_log_level: '3'
