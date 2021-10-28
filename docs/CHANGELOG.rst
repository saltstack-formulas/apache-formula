
Changelog
=========

`1.2.2 <https://github.com/saltstack-formulas/apache-formula/compare/v1.2.1...v1.2.2>`_ (2021-10-28)
--------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **redhat:** use correct vhostdir, sitesdir and logrotate script for redhat family (\ `#376 <https://github.com/saltstack-formulas/apache-formula/issues/376>`_\ ) (\ `c4b8538 <https://github.com/saltstack-formulas/apache-formula/commit/c4b85381288ae878207ffa5d2cc36cabc916e8f1>`_\ )

`1.2.1 <https://github.com/saltstack-formulas/apache-formula/compare/v1.2.0...v1.2.1>`_ (2021-10-20)
--------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **vhosts:** reset ``cleanup`` to previous and use dedicated ``clean`` SLS (\ `0c6c1d3 <https://github.com/saltstack-formulas/apache-formula/commit/0c6c1d36e261ae6f851cb9b6ed2d1319af460a73>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **kitchen+ci:** update with latest CVE pre-salted images [skip ci] (\ `a3d49f1 <https://github.com/saltstack-formulas/apache-formula/commit/a3d49f185274efc6d1530580daf03b1ad2be0e2d>`_\ )
* test for upstream Salt regressions in ``master`` instances (2021-W37a) (\ `69dcfd9 <https://github.com/saltstack-formulas/apache-formula/commit/69dcfd9c3bf49416e6c77d8e982446d99af3b95c>`_\ )

Documentation
^^^^^^^^^^^^^


* **readme:** document vhosts clean/cleanup (\ `2d72dff <https://github.com/saltstack-formulas/apache-formula/commit/2d72dff82bdcf9c0d30f6735c315a655ebea483d>`_\ ), closes `#372 <https://github.com/saltstack-formulas/apache-formula/issues/372>`_

`1.2.0 <https://github.com/saltstack-formulas/apache-formula/compare/v1.1.8...v1.2.0>`_ (2021-08-28)
--------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **suse:** use correct vhostdir and sitesdir for suse family (\ `#369 <https://github.com/saltstack-formulas/apache-formula/issues/369>`_\ ) (\ `fe0ceb7 <https://github.com/saltstack-formulas/apache-formula/commit/fe0ceb78b7d4e9f67bc4d5b684b847bdcc604b20>`_\ ), closes `/documentation.suse.com/sles/15-SP3/html/SLES-all/cha-apache2.html#sec-apache2 <https://github.com//documentation.suse.com/sles/15-SP3/html/SLES-all/cha-apache2.html/issues/sec-apache2>`_

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **3003.1:** update inc. AlmaLinux, Rocky & ``rst-lint`` [skip ci] (\ `2e116ec <https://github.com/saltstack-formulas/apache-formula/commit/2e116ec4123b846edd85b651c9634e03cb102abf>`_\ )
* **freebsd:** update with latest pre-salted Vagrant boxes [skip ci] (\ `d679580 <https://github.com/saltstack-formulas/apache-formula/commit/d67958043df41515350a4b02c5de81e0d83eb813>`_\ )
* **gemfile+lock:** use ``ssf`` customised ``inspec`` repo [skip ci] (\ `5dd7009 <https://github.com/saltstack-formulas/apache-formula/commit/5dd700944b413411fc3557063125f22c1eb6f62a>`_\ )
* **kitchen:** move ``provisioner`` block & update ``run_command`` [skip ci] (\ `0d1a6dc <https://github.com/saltstack-formulas/apache-formula/commit/0d1a6dc75d1a781518bf4d7262dbfb4cfbc2c0b9>`_\ )
* **kitchen+ci:** update with latest ``3003.2`` pre-salted images [skip ci] (\ `d3641d7 <https://github.com/saltstack-formulas/apache-formula/commit/d3641d7f0d427d9e8be9d20bd03f84977d1cba22>`_\ )
* add Debian 11 Bullseye & update ``yamllint`` configuration [skip ci] (\ `7741b90 <https://github.com/saltstack-formulas/apache-formula/commit/7741b90ff66719c1abfca3fb306d07ee47cbd4c8>`_\ )

Features
^^^^^^^^


* **alma+rocky:** add platforms (based on CentOS 8) [skip ci] (\ `4353e57 <https://github.com/saltstack-formulas/apache-formula/commit/4353e57a1b652186f552472f16f1b06f8fb4f0a1>`_\ )

`1.1.8 <https://github.com/saltstack-formulas/apache-formula/compare/v1.1.7...v1.1.8>`_ (2021-06-28)
--------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **register_site:** correct semicolon to colon (\ `4cf848d <https://github.com/saltstack-formulas/apache-formula/commit/4cf848da05eb558012a465bd6996749982908667>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **gitlab-ci:** ignore line to avoid ``yamllint`` violation [skip ci] (\ `a742f4e <https://github.com/saltstack-formulas/apache-formula/commit/a742f4ee00c08e7db34c2f3adcb8c90a58c851aa>`_\ )
* **gitlab-ci:** use ``pandoc``\ -enabled ``semantic-release`` image [skip ci] (\ `3bf9c6e <https://github.com/saltstack-formulas/apache-formula/commit/3bf9c6e6a942b86fd16ca4b222bb6a1781f4e09d>`_\ )
* **kitchen+gitlab:** remove Ubuntu 16.04 & Fedora 32 (EOL) [skip ci] (\ `10ce382 <https://github.com/saltstack-formulas/apache-formula/commit/10ce3822dd7ea9868ee986a08e2ccd48bd0026ee>`_\ )
* **kitchen+gitlab:** remove Ubuntu 16.04 & Fedora 32 (EOL) [skip ci] (\ `57e9873 <https://github.com/saltstack-formulas/apache-formula/commit/57e98736247b196ad650528b705379fecf58c835>`_\ )

`1.1.7 <https://github.com/saltstack-formulas/apache-formula/compare/v1.1.6...v1.1.7>`_ (2021-05-14)
--------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **mod_pagespeed:** add missing colon to ``file.directory`` (\ `a8b87a5 <https://github.com/saltstack-formulas/apache-formula/commit/a8b87a583e91b7f69cff8485cb56249c3707ce74>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* add ``arch-master`` to matrix and update ``.travis.yml`` [skip ci] (\ `069388b <https://github.com/saltstack-formulas/apache-formula/commit/069388be3a624a91b955227188ddee7c3650045e>`_\ )

`1.1.6 <https://github.com/saltstack-formulas/apache-formula/compare/v1.1.5...v1.1.6>`_ (2021-05-08)
--------------------------------------------------------------------------------------------------------

Documentation
^^^^^^^^^^^^^


* **changelog:** regenerate via. ``semantic-release`` (\ `de8c82c <https://github.com/saltstack-formulas/apache-formula/commit/de8c82c7533e36e720cf2e44c46154cd8cd3f540>`_\ )

`1.1.5 <https://github.com/saltstack-formulas/apache-formula/compare/v1.1.4...v1.1.5>`_ (2021-05-08)
--------------------------------------------------------------------------------------------------------

Documentation
^^^^^^^^^^^^^


* **changelog:** regenerate via. ``semantic-release`` (\ `198d525 <https://github.com/saltstack-formulas/apache-formula/commit/198d525a6a552c8c83842c26f6c74a43ffcd4b79>`_\ )

`1.1.4 <https://github.com/saltstack-formulas/apache-formula/compare/v1.1.3...v1.1.4>`_ (2021-05-08)
--------------------------------------------------------------------------------------------------------

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **gitlab-ci:** remove adjustments made during Antora test [skip ci] (\ `0c7082f <https://github.com/saltstack-formulas/apache-formula/commit/0c7082f8d911185390e8ab03077f61c6027461f7>`_\ )

Documentation
^^^^^^^^^^^^^


* **changelog:** regenerate via. ``semantic-release`` (\ `e1f1fa7 <https://github.com/saltstack-formulas/apache-formula/commit/e1f1fa7d8f3ea5a8c307badcfe890f96f57c580f>`_\ )
* **changelog:** regenerate via. ``semantic-release`` (\ `a1be1d2 <https://github.com/saltstack-formulas/apache-formula/commit/a1be1d21dceb304278e680a5ade56c51882e4a0b>`_\ )
* **changelog:** regenerate via. ``semantic-release`` (\ `56efd35 <https://github.com/saltstack-formulas/apache-formula/commit/56efd35f85fe049b4cdcbd082e38d547bd306a39>`_\ )

`1.1.3 <https://github.com/saltstack-formulas/apache-formula/compare/v1.1.2...v1.1.3>`_ (2021-04-30)
--------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **config/vhosts/standard:** remove erroneous trailing colon (\ `dedb9e2 <https://github.com/saltstack-formulas/apache-formula/commit/dedb9e2f400aa9d391ae39c22f8a4fec1e7bc220>`_\ ), closes `#302 <https://github.com/saltstack-formulas/apache-formula/issues/302>`_

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **kitchen+gitlab:** adjust matrix to add ``3003`` [skip ci] (\ `3c21740 <https://github.com/saltstack-formulas/apache-formula/commit/3c21740ba52fa5c2b5cf39cddce6a42d13d17988>`_\ )
* **vagrant:** add FreeBSD 13.0 [skip ci] (\ `298fdf4 <https://github.com/saltstack-formulas/apache-formula/commit/298fdf4fb569a3d1d4a9dadedb4c3924bcb8cc9a>`_\ )
* **vagrant:** use pre-salted boxes & conditional local settings [skip ci] (\ `f354ace <https://github.com/saltstack-formulas/apache-formula/commit/f354ace8e7d328580a60dbc09703ddc54a6af0a0>`_\ )

`1.1.2 <https://github.com/saltstack-formulas/apache-formula/compare/v1.1.1...v1.1.2>`_ (2021-04-03)
--------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **freebsd:** fix ``default`` suite implementation and tests (\ `0a0f69e <https://github.com/saltstack-formulas/apache-formula/commit/0a0f69ee2fc8168696f9f9c4ae786389ff894615>`_\ )
* **freebsd:** fix ``modsecurity`` suite implementation and tests (\ `bc9aa78 <https://github.com/saltstack-formulas/apache-formula/commit/bc9aa78437d14cf26605f58a3c1e17caed8f05bc>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* enable Vagrant-based testing using GitHub Actions (\ `6e094e2 <https://github.com/saltstack-formulas/apache-formula/commit/6e094e2527748cd4d72690b9289836b17f9289c7>`_\ )
* **gemfile+lock:** use ``ssf`` customised ``kitchen-docker`` repo [skip ci] (\ `53ac463 <https://github.com/saltstack-formulas/apache-formula/commit/53ac4638f3b902c1fd65a64d4344387e26c466c1>`_\ )
* **gitlab-ci:** reset after update hook for ``rubocop`` [skip ci] (\ `6d40ab7 <https://github.com/saltstack-formulas/apache-formula/commit/6d40ab7634a42048a0f2b3f2e1173cf2da2a8716>`_\ )
* **kitchen+ci:** use latest pre-salted images (after CVE) [skip ci] (\ `69e9d30 <https://github.com/saltstack-formulas/apache-formula/commit/69e9d304fb7d637df1856e0d8ab66be7ddce86c4>`_\ )
* **kitchen+gitlab-ci:** use latest pre-salted images [skip ci] (\ `21cb59d <https://github.com/saltstack-formulas/apache-formula/commit/21cb59daa2f70ce6cc46f8d241fb6032c932746c>`_\ )
* **pre-commit:** update hook for ``rubocop`` (\ `2c090c3 <https://github.com/saltstack-formulas/apache-formula/commit/2c090c3a835e42bd07f0788f4b0965f1c3405662>`_\ )

Documentation
^^^^^^^^^^^^^


* **readme:** add ``Testing with Vagrant`` section (\ `5a6b203 <https://github.com/saltstack-formulas/apache-formula/commit/5a6b203bb18f9f28146f33af8175fc3b8c059077>`_\ )

Tests
^^^^^


* standardise use of ``share`` suite & ``_mapdata`` state [skip ci] (\ `e7c2d20 <https://github.com/saltstack-formulas/apache-formula/commit/e7c2d20f06f23a5ce8a5edaae513775aca0914ab>`_\ )
* **nomodsecurity:** use adjusted ``modules`` suite instead (\ `838b917 <https://github.com/saltstack-formulas/apache-formula/commit/838b9172217c5e067ea0e4a6d2f155ecd1a4b053>`_\ )

`1.1.1 <https://github.com/saltstack-formulas/apache-formula/compare/v1.1.0...v1.1.1>`_ (2021-01-04)
--------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **memory:** pass variable not dict (\ `2830081 <https://github.com/saltstack-formulas/apache-formula/commit/28300814fc0a83244ab64a4a87f104d67de4ac53>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **commitlint:** ensure ``upstream/master`` uses main repo URL [skip ci] (\ `0145922 <https://github.com/saltstack-formulas/apache-formula/commit/0145922b52f21469c00c85bf46503411ffd11c56>`_\ )
* **gitlab-ci:** add ``rubocop`` linter (with ``allow_failure``\ ) [skip ci] (\ `bbf012b <https://github.com/saltstack-formulas/apache-formula/commit/bbf012b82eed50db3c35cb25a10d9ca36e40487b>`_\ )
* **gitlab-ci:** use GitLab CI as Travis CI replacement (\ `26208c4 <https://github.com/saltstack-formulas/apache-formula/commit/26208c47c644608b00adfa8474616305e7a55e36>`_\ )

`1.1.0 <https://github.com/saltstack-formulas/apache-formula/compare/v1.0.5...v1.1.0>`_ (2020-10-14)
--------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **ssl.conf:** fix pillar keys for SSLStapling in ssl.conf on debian (\ `65043f8 <https://github.com/saltstack-formulas/apache-formula/commit/65043f8a6142f7b9988cd406988b524aa9f0a1f2>`_\ )

Code Refactoring
^^^^^^^^^^^^^^^^


* **ssl.conf:** reduce newlines in ssl.conf on debian (\ `b99b7b7 <https://github.com/saltstack-formulas/apache-formula/commit/b99b7b71add9fc1102d1b62eafada8358dfd5e68>`_\ )
* **vhosts:** reduce empty lines in standard.tmpl and proxy.tmpl (\ `4b79c1d <https://github.com/saltstack-formulas/apache-formula/commit/4b79c1dddb1999452b618153792a8710bedbb76e>`_\ )

Features
^^^^^^^^


* **ssl.conf:** add SSLSessionTickets to ssl.conf on debian (\ `41a7a83 <https://github.com/saltstack-formulas/apache-formula/commit/41a7a83af0bf1bf4d4dde0f8ea522135dd721738>`_\ )

`1.0.5 <https://github.com/saltstack-formulas/apache-formula/compare/v1.0.4...v1.0.5>`_ (2020-10-14)
--------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **clean:** remove entire apache config directory (\ `cac5f35 <https://github.com/saltstack-formulas/apache-formula/commit/cac5f357a47d1bdd40371aca97181b490430c158>`_\ )

Code Refactoring
^^^^^^^^^^^^^^^^


* **package:** remove unnecessary state (\ `fb81d8e <https://github.com/saltstack-formulas/apache-formula/commit/fb81d8e69450702bcd3eaa6e5243fce02715c819>`_\ )

Documentation
^^^^^^^^^^^^^


* **readme:** add mod watchdog to pillar example (\ `e0043dd <https://github.com/saltstack-formulas/apache-formula/commit/e0043dd7bafcab1b87822d0c831b91e10936b291>`_\ )

`1.0.4 <https://github.com/saltstack-formulas/apache-formula/compare/v1.0.3...v1.0.4>`_ (2020-10-14)
--------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **debian:** don't execute a2enmod on every run (\ `5844322 <https://github.com/saltstack-formulas/apache-formula/commit/5844322de46b82cad6beedd2b99c8808df8f2485>`_\ )
* **debian:** fix default moddir on debian (\ `c17601e <https://github.com/saltstack-formulas/apache-formula/commit/c17601ee42cc4aa0222ec60e8ec3176d902b32f1>`_\ )
* **logs:** don't change owners of logfiles with salt (\ `382e053 <https://github.com/saltstack-formulas/apache-formula/commit/382e053c58c1b4e4f3ceb1af8fd75e2f56f6d153>`_\ )
* **vhosts:** replace %O with %b in default LogFormat (\ `2b52e11 <https://github.com/saltstack-formulas/apache-formula/commit/2b52e11a8a91b0837a442bac816e7383dbe6fb13>`_\ )

Tests
^^^^^


* **pillar:** remove modules that aren't installed from being enabled (\ `47ec5fc <https://github.com/saltstack-formulas/apache-formula/commit/47ec5fcc343ea889898e2418cd7c03a4a75c8f87>`_\ )

`1.0.3 <https://github.com/saltstack-formulas/apache-formula/compare/v1.0.2...v1.0.3>`_ (2020-10-13)
--------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **config:** fix old apache.service usage (\ `32f05e5 <https://github.com/saltstack-formulas/apache-formula/commit/32f05e5a66940ad86ce21831598c478b7099ed3a>`_\ )

`1.0.2 <https://github.com/saltstack-formulas/apache-formula/compare/v1.0.1...v1.0.2>`_ (2020-10-12)
--------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **package:** remove own_default_vhost and debian_full from config.init (\ `7691b58 <https://github.com/saltstack-formulas/apache-formula/commit/7691b589d7a1b0a87aaf9b13282e6ca154c5787c>`_\ )
* **package:** remove own_default_vhost and debian_full from config.init (\ `441459e <https://github.com/saltstack-formulas/apache-formula/commit/441459e56f3a8b091671839042efae2d7020380d>`_\ )

`1.0.1 <https://github.com/saltstack-formulas/apache-formula/compare/v1.0.0...v1.0.1>`_ (2020-10-10)
--------------------------------------------------------------------------------------------------------

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **pre-commit:** finalise ``rstcheck`` configuration [skip ci] (\ `1c2125c <https://github.com/saltstack-formulas/apache-formula/commit/1c2125c251016097e7d2c0694bf0245a3644605e>`_\ )

Documentation
^^^^^^^^^^^^^


* **example:** document redirect 80->443 fix `#226 <https://github.com/saltstack-formulas/apache-formula/issues/226>`_ (\ `e15803b <https://github.com/saltstack-formulas/apache-formula/commit/e15803b4b12df2b6e625673409bc854b1d1dd751>`_\ )
* **readme:** fix ``rstcheck`` violation [skip ci] (\ `2747e35 <https://github.com/saltstack-formulas/apache-formula/commit/2747e35ce1e49d46a1fd5f8613ce73517aaed095>`_\ ), closes `/travis-ci.org/github/myii/apache-formula/builds/731605038#L255 <https://github.com//travis-ci.org/github/myii/apache-formula/builds/731605038/issues/L255>`_

`1.0.0 <https://github.com/saltstack-formulas/apache-formula/compare/v0.41.1...v1.0.0>`_ (2020-10-05)
---------------------------------------------------------------------------------------------------------

Code Refactoring
^^^^^^^^^^^^^^^^


* **formula:** align to template-formula & improve ci features (\ `47818fc <https://github.com/saltstack-formulas/apache-formula/commit/47818fc360fc87c94f51f2c2c7ff9317d4ecf875>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **pre-commit:** add to formula [skip ci] (\ `5532ed7 <https://github.com/saltstack-formulas/apache-formula/commit/5532ed7a5b1c9afb5ca4348d3984c5ff357bacad>`_\ )
* **pre-commit:** enable/disable ``rstcheck`` as relevant [skip ci] (\ `233111a <https://github.com/saltstack-formulas/apache-formula/commit/233111af11dd25b573928e746f19b06bcdbf19b9>`_\ )

BREAKING CHANGES
^^^^^^^^^^^^^^^^


* **formula:** 'apache.sls' converted to new style 'init.ssl'
* **formula:** "logrotate.sls" became "config/logrotate.sls"
* **formula:** "debian_full.sls" became "config/debian_full.sls"
* **formula:** "flags.sls" became "config/flags.sls"
* **formula:** "manage_security" became "config/manage_security.sls"
* **formula:** "mod\ **.sls" became "config/mod*\ *.sls"
* **formula:** "no_default_host.sls" became "config/no_default_host.sls"
* **formula:** "own_default_host.sls" became "config/own_default_host.sls"
* **formula:** "register_site.sls" became "config/register_site.sls"
* **formula:** "server_status.sls" became "config/server_status.sls"
* **formula:** "vhosts/" became "config/vhosts/"
* **formula:** "mod_security/" became "config/mod_security/"

NOT-BREAKING CHANGE: 'config.sls' became 'config/init.sls'
NOT-BREAKING CHANGE: 'uninstall.sls' symlinked to 'clean.sls'

`0.41.1 <https://github.com/saltstack-formulas/apache-formula/compare/v0.41.0...v0.41.1>`_ (2020-07-20)
-----------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **server-status:** enable module in Debian family (\ `632802a <https://github.com/saltstack-formulas/apache-formula/commit/632802a5a946d2f05c40d9038d6f2ad596fafc58>`_\ )
* **server-status:** manage module in debian (\ `eafa419 <https://github.com/saltstack-formulas/apache-formula/commit/eafa4196d9495bc975c7e1e7036969bdaba1441d>`_\ )

Tests
^^^^^


* **default+modules:** add modules' tests suite (\ `b253625 <https://github.com/saltstack-formulas/apache-formula/commit/b25362535ae01dd140218b131a8e991d3a10cbe5>`_\ )

`0.41.0 <https://github.com/saltstack-formulas/apache-formula/compare/v0.40.0...v0.41.0>`_ (2020-07-16)
-----------------------------------------------------------------------------------------------------------

Features
^^^^^^^^


* **vhosts/standard:** add support for ScriptAlias in standard vhost (\ `b88b437 <https://github.com/saltstack-formulas/apache-formula/commit/b88b437308ff5d6bc504dabf9b69153db89f5b10>`_\ )

`0.40.0 <https://github.com/saltstack-formulas/apache-formula/compare/v0.39.5...v0.40.0>`_ (2020-07-16)
-----------------------------------------------------------------------------------------------------------

Features
^^^^^^^^


* **redhat/apache-2.x.config.jinja:** allow override of default_charset (\ `648f589 <https://github.com/saltstack-formulas/apache-formula/commit/648f589cc30684550c972d9cc4087e9e8b3fdc80>`_\ )

`0.39.5 <https://github.com/saltstack-formulas/apache-formula/compare/v0.39.4...v0.39.5>`_ (2020-06-21)
-----------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **vhosts/cleanup:** check ``sites-enabled`` dir exists before listing it (\ `88373e3 <https://github.com/saltstack-formulas/apache-formula/commit/88373e38f55eab61cf1c4edc68324f3da48f7646>`_\ ), closes `#278 <https://github.com/saltstack-formulas/apache-formula/issues/278>`_

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **gemfile.lock:** add to repo with updated ``Gemfile`` [skip ci] (\ `61b903e <https://github.com/saltstack-formulas/apache-formula/commit/61b903e7803eb80b50130834b90ca86d26b9d6c8>`_\ )
* **kitchen:** use ``saltimages`` Docker Hub where available [skip ci] (\ `6895fb9 <https://github.com/saltstack-formulas/apache-formula/commit/6895fb9764e9cebcbbff05763e367401d6cad959>`_\ )
* **kitchen+travis:** remove ``master-py2-arch-base-latest`` [skip ci] (\ `16bb1b0 <https://github.com/saltstack-formulas/apache-formula/commit/16bb1b06e351efdf9994676de38dec7b0ecd639d>`_\ )
* **travis:** add notifications => zulip [skip ci] (\ `2417a75 <https://github.com/saltstack-formulas/apache-formula/commit/2417a75fe218bd04c719f8eb2e2a7e402a20928e>`_\ )
* **workflows/commitlint:** add to repo [skip ci] (\ `2ce966d <https://github.com/saltstack-formulas/apache-formula/commit/2ce966d031e9044e8794dc93f605ce780fd99f12>`_\ )

`0.39.4 <https://github.com/saltstack-formulas/apache-formula/compare/v0.39.3...v0.39.4>`_ (2020-04-02)
-----------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **mod_ssl:** update mod_ssl package variable to prevent clashes (\ `5591be2 <https://github.com/saltstack-formulas/apache-formula/commit/5591be26fddd234ebaed0e024969c45b6536ba82>`_\ )

`0.39.3 <https://github.com/saltstack-formulas/apache-formula/compare/v0.39.2...v0.39.3>`_ (2020-04-02)
-----------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **debian:** generate remoteip conf before a2enconf (\ `1ed69f6 <https://github.com/saltstack-formulas/apache-formula/commit/1ed69f6c6fab0eb583949105e9e29e58b6ba32a3>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **kitchen:** avoid using bootstrap for ``master`` instances [skip ci] (\ `275b5d5 <https://github.com/saltstack-formulas/apache-formula/commit/275b5d5e69fa79f1010852d65f0fcb65cadf735d>`_\ )
* **travis:** use ``major.minor`` for ``semantic-release`` version [skip ci] (\ `08cced2 <https://github.com/saltstack-formulas/apache-formula/commit/08cced29134ca47824e82ee6afa794233cdb5faa>`_\ )

`0.39.2 <https://github.com/saltstack-formulas/apache-formula/compare/v0.39.1...v0.39.2>`_ (2019-12-20)
-----------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **redhat:** add user & group lookup to configs (\ `36ad2b2 <https://github.com/saltstack-formulas/apache-formula/commit/36ad2b24424936a4badeb7b4b2b26ee0d39e55f2>`_\ )

`0.39.1 <https://github.com/saltstack-formulas/apache-formula/compare/v0.39.0...v0.39.1>`_ (2019-12-20)
-----------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **mod_mpm:** cast to int to avoid Jinja type mismatch error (\ `21045c7 <https://github.com/saltstack-formulas/apache-formula/commit/21045c7a7b46d639c2d81c5793ad6e6d9d34b66b>`_\ )

`0.39.0 <https://github.com/saltstack-formulas/apache-formula/compare/v0.38.2...v0.39.0>`_ (2019-12-20)
-----------------------------------------------------------------------------------------------------------

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **gemfile:** restrict ``train`` gem version until upstream fix [skip ci] (\ `13be6f9 <https://github.com/saltstack-formulas/apache-formula/commit/13be6f9fac5aae55c48f74c784335c61d7fbaaf2>`_\ )
* **travis:** apply changes from build config validation [skip ci] (\ `0aac479 <https://github.com/saltstack-formulas/apache-formula/commit/0aac479c253f95b7fdcb1505476638c2d703bc77>`_\ )
* **travis:** opt-in to ``dpl v2`` to complete build config validation (\ `19e90ea <https://github.com/saltstack-formulas/apache-formula/commit/19e90ea2d6ef91118ebf59817ef4c91ad876af54>`_\ )
* **travis:** quote pathspecs used with ``git ls-files`` [skip ci] (\ `6608ddf <https://github.com/saltstack-formulas/apache-formula/commit/6608ddf8c5a361b93e6a44658ab1e306953566bf>`_\ )
* **travis:** run ``shellcheck`` during lint job [skip ci] (\ `2ff6b2f <https://github.com/saltstack-formulas/apache-formula/commit/2ff6b2f17e1fd48b5f0a4156c2dbd90f07f27025>`_\ )
* **travis:** use build config validation (beta) [skip ci] (\ `73160b2 <https://github.com/saltstack-formulas/apache-formula/commit/73160b249124df6bbd36b113df71724c019a118f>`_\ )

Features
^^^^^^^^


* **server-status:** allow remote servers to reach server-status page (\ `a3c0022 <https://github.com/saltstack-formulas/apache-formula/commit/a3c0022d7988eee0ec43d939bced91dee9fec0e1>`_\ )

`0.38.2 <https://github.com/saltstack-formulas/apache-formula/compare/v0.38.1...v0.38.2>`_ (2019-11-07)
-----------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **apache/modules.sls:** fix duplicated ID (\ `57afd71 <https://github.com/saltstack-formulas/apache-formula/commit/57afd71627eb554138c8d5ec9cc790d899ed80ff>`_\ )

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
