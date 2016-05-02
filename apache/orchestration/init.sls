#!jinja|yaml
{% set node_ids = salt['pillar.get']('apache:lookup:pcs:node_ids') -%}
{% set admin_node_id = salt['pillar.get']('apache:lookup:pcs:admin_node_id') -%}

# node_ids: {{node_ids|json}}
# admin_node_id: {{admin_node_id}}

apache_orchestration__install:
  salt.state:
    - tgt: {{node_ids|json}}
    - tgt_type: list
    - expect_minions: True
    - sls: apache.server_status

apache_orchestration__pcs:
  salt.state:
    - tgt: {{admin_node_id}}
    - expect_minions: True
    - sls: apache.pcs
    - require:
      - salt: apache_orchestration__install
