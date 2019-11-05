
Changelog
=========

`0.38.1 <https://github.com/saltstack-formulas/apache-formula/compare/v0.38.0...v0.38.1>`_ (2019-11-05)
-----------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **mod_perl2.sls:** fix a2enmod perl2 error (\ `fba8d21 <https://github.com/saltstack-formulas/apache-formula/commit/fba8d217944c8b5a0abf19cdbae7d41d1ec5bf2e>`_\ )
* **release.config.js:** use full commit hash in commit link [skip ci] (\ `dc5593c <https://github.com/saltstack-formulas/apache-formula/commit/dc5593cfdf775e065ea5f680f2ed2b6b7c80d8ed>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **kitchen:** use ``debian-10-master-py3`` instead of ``develop`` [skip ci] (\ `09d82a5 <https://github.com/saltstack-formulas/apache-formula/commit/09d82a581caa09298d3d99ded215c5e45c5b619f>`_\ )
* **kitchen:** use ``develop`` image until ``master`` is ready (\ ``amazonlinux``\ ) [skip ci] (\ `d0bf6f3 <https://github.com/saltstack-formulas/apache-formula/commit/d0bf6f37969a9a97a6e368278e0f9eb40431f2f1>`_\ )
* **kitchen+travis:** upgrade matrix after ``2019.2.2`` release [skip ci] (\ `fc0f869 <https://github.com/saltstack-formulas/apache-formula/commit/fc0f869b78ef56369e1cfb6ff3d62179f703efa0>`_\ )
* **travis:** update ``salt-lint`` config for ``v0.0.10`` [skip ci] (\ `2622d48 <https://github.com/saltstack-formulas/apache-formula/commit/2622d48b4ccb01cd70555d46759d79d82d1db7bf>`_\ )

Performance Improvements
^^^^^^^^^^^^^^^^^^^^^^^^


* **travis:** improve ``salt-lint`` invocation [skip ci] (\ `bf75770 <https://github.com/saltstack-formulas/apache-formula/commit/bf7577022040a155de8b3ab4f557dd05484d278c>`_\ )

`0.38.0 <https://github.com/saltstack-formulas/apache-formula/compare/v0.37.4...v0.38.0>`_ (2019-10-20)
-----------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **apache-2.2.config.jinja:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/apache-formula/commit/f4045ef>`_\ )
* **apache-2.4.config.jinja:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/apache-formula/commit/e2c1c2e>`_\ )
* **flags.sls:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/apache-formula/commit/a146c59>`_\ )
* **init.sls:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/apache-formula/commit/8465eb4>`_\ )
* **map.jinja:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/apache-formula/commit/d011324>`_\ )
* **mod_geoip.sls:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/apache-formula/commit/e55ef9b>`_\ )
* **modsecurity.conf.jinja:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/apache-formula/commit/2a79d05>`_\ )
* **modules.sls:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/apache-formula/commit/55d11f8>`_\ )
* **server_status.sls:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/apache-formula/commit/da9a592>`_\ )
* **uninstall.sls:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/apache-formula/commit/ed7dc7b>`_\ )
* **vhosts/cleanup.sls:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/apache-formula/commit/b0bbd0b>`_\ )
* **vhosts/minimal.tmpl:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/apache-formula/commit/146dc67>`_\ )
* **vhosts/proxy.tmpl:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/apache-formula/commit/e7c9fbb>`_\ )
* **vhosts/redirect.tmpl:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/apache-formula/commit/0a41b19>`_\ )
* **vhosts/standard.tmpl:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/apache-formula/commit/1bad58d>`_\ )
* **yamllint:** fix all errors (\ ` <https://github.com/saltstack-formulas/apache-formula/commit/97f6ead>`_\ )

Documentation
^^^^^^^^^^^^^


* **formula:** use standard structure (\ ` <https://github.com/saltstack-formulas/apache-formula/commit/701929d>`_\ )
* **readme:** move to ``docs/`` directory and modify accordingly (\ ` <https://github.com/saltstack-formulas/apache-formula/commit/6933f0e>`_\ )

Features
^^^^^^^^


* **semantic-release:** implement for this formula (\ ` <https://github.com/saltstack-formulas/apache-formula/commit/34d1f7c>`_\ )

Tests
^^^^^


* **mod_security_spec:** convert from Serverspec to InSpec (\ ` <https://github.com/saltstack-formulas/apache-formula/commit/68b971b>`_\ )
