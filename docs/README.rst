.. _readme:

apache
======

|img_travis| |img_sr|

.. |img_travis| image:: https://travis-ci.com/saltstack-formulas/apache-formula.svg?branch=master
   :alt: Travis CI Build Status
   :scale: 100%
   :target: https://travis-ci.com/saltstack-formulas/apache-formula
.. |img_sr| image:: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
   :alt: Semantic Release
   :scale: 100%
   :target: https://github.com/semantic-release/semantic-release

Formulas to set up and configure the Apache HTTP server.

.. contents:: **Table of Contents**

General notes
-------------

See the full `SaltStack Formulas installation and usage instructions
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

If you are interested in writing or contributing to formulas, please pay attention to the `Writing Formula Section
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#writing-formulas>`_.

If you want to use this formula, please pay attention to the ``FORMULA`` file and/or ``git tag``,
which contains the currently released version. This formula is versioned according to `Semantic Versioning <http://semver.org/>`_.

See `Formula Versioning Section <https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#versioning>`_ for more details.

Contributing to this repo
-------------------------

**Commit message formatting is significant!!**

Please see `How to contribute <https://github.com/saltstack-formulas/.github/blob/master/CONTRIBUTING.rst>`_ for more details.

Available states
----------------

.. contents::
   :local:

``apache``
^^^^^^^^^^

Installs the Apache package and starts the service.

``apache.config``
^^^^^^^^^^^^^^^^^

Metastate to apply all apache configuration


``apache.config.file``
^^^^^^^^^^^^^^^^^^^^^^

Configures apache based on os_family

``apache.config.flags``
^^^^^^^^^^^^^^^^^^^^^^^

Configures apache flags on SuSE

``apache.config.certificates``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Deploy SSL certificates from pillars

``apache.config.modules``
^^^^^^^^^^^^^^^^^^^^^^^^^

Metastate to Enable and disable Apache modules.

``apache.config.modules.mod_mpm``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Configures the apache mpm modules on Debian ``mpm_prefork``, ``mpm_worker`` or ``mpm_event`` (Debian Only)

``apache.config.modules.mod_rewrite``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Enabled the Apache module mod_rewrite (Debian and FreeBSD only)

``apache.config.modules.mod_proxy``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Enables the Apache module mod_proxy. (Debian and FreeBSD only)

``apache.config.modules.mod_proxy_http``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Enables the Apache module mod_proxy_http and requires the Apache module mod_proxy to be enabled. (Debian Only)

``apache.config.modules.mod_proxy_fcgi``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Enables the Apache module mod_proxy_fcgi and requires the Apache module mod_proxy to be enabled. (Debian Only)

``apache.config.modules.mod_wsgi``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Installs the mod_wsgi package and enables the Apache module.

``apache.config.modules.mod_actions``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Enables the Apache module mod_actions. (Debian Only)

``apache.config.modules.mod_headers``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Enables the Apache module mod_headers. (Debian Only)

``apache.config.modules.mod_pagespeed``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Installs and Enables the mod_pagespeed module. (Debian and RedHat Only)

``apache.config.modules.mod_perl2``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Installs and enables the mod_perl2 module (Debian and FreeBSD only)

``apache.config.modules.mod_geoip``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Installs and enables the mod_geoIP (RedHat only)

``apache.config.modules.mod_php5``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Installs and enables the mod_php5 module

``apache.config.modules.mod_cgi``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Enables mod_cgi. (FreeBSD only)

``apache.config.modules.mod_fcgid``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Installs and enables the mod_fcgid module (Debian only)

``apache.config.modules.mod_fastcgi``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Installs and enables the mod_fastcgi module

``apache.config.modules.mod_dav_svn``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Installs and enables the mod_dav_svn module (Debian only)

``apache.config.modules.mod_security``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Installs an enables the `Apache mod_security2 WAF <http://modsecurity.org/>`_
using data from Pillar. (Debian and RedHat Only)

Allows you to install the basic Core Rules (CRS) and some basic configuration for mod_security2

``apache.config.modules.mod_security.rules``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state can create symlinks based on basic Core Rules package. (Debian only)
Or it can distribute a mod_security rule file and place it /etc/modsecurity/

``apache.config.modules.mod_socache_shmcb``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Enables mod_socache_shmcb. (FreeBSD only)

``apache.config.modules.mod_ssl``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Installs and enables the mod_ssl module (Debian, RedHat and FreeBSD only)

``apache.config.modules.mod_suexec``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Enables mod_suexec. (FreeBSD only)

``apache.config.modules.mod_vhost_alias``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Enables the Apache module vhost_alias (Debian Only)

``apache.config.modules.mod_remoteip``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Enables and configures the Apache module mod_remoteip using data from Pillar. (Debian Only)

``apache.config.modules.mod_xsendfile``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Installs and enables mod_xsendfile module. (Debian Only)

``apache.config.own_default_vhost``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Replace default vhost with own version. By default, it's 503 code. (Debian Only)

``apache.config.no_default_vhost``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Remove the default vhost. (Debian Only)

``apache.config.vhosts.standard``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Configures Apache name-based virtual hosts and creates virtual host directories using data from Pillar.

Example Pillar:

.. code:: yaml

    apache:
      sites:
        example.com: # must be unique; used as an ID declaration in Salt; also passed to the template context as {{ id }}
          template_file: salt://apache/vhosts/standard.tmpl

When using the provided templates, one can use a space separated list
of interfaces to bind to. For example, to bind both IPv4 and IPv6:
	
.. code:: yaml

    apache:
      sites:
        example.com:
          interface: '1.2.3.4 [2001:abc:def:100::3]'
	  
``apache.config.manage_security``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Configures Apache's security.conf options by reassinging them using data from Pillar.

``apache.config.modules.mod_status``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Configures Apache's server_status handler for localhost

``apache.config.debian_full``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Installs and configures Apache on Debian and Ubuntu systems.

``apache.config.clean``
^^^^^^^^^^^^^^^^^^^^^^^

Metastate to cleanup all apache configuration.


``apache.clean``
^^^^^^^^^^^^^^^^

Stops the Apache service and uninstalls the package.

These states are ordered using the ``order`` declaration. Different stages
are divided into the following number ranges:

1)  apache will use 1-500 for ordering
2)  apache will reserve 1  -100 as unused
3)  apache will reserve 101-150 for pre pkg install
4)  apache will reserve 151-200 for pkg install
5)  apache will reserve 201-250 for pkg configure
6)  apache will reserve 251-300 for downloads, git stuff, load data
7)  apache will reserve 301-400 for unknown purposes
8)  apache will reserve 401-450 for service restart-reloads
9)  apache WILL reserve 451-460 for service.running
10) apache will reserve 461-500 for cmd requiring operational services

Example Pillar:

.. code:: yaml

    apache:
      register-site:
        # any name as an array index, and you can duplicate this section
        {{UNIQUE}}:
          name: 'my name'
          path: 'salt://path/to/sites-available/conf/file'
          state: 'enabled'

Testing
-------

Linux testing is done with ``kitchen-salt``.

Requirements
^^^^^^^^^^^^

* Ruby
* Docker

.. code-block:: bash

   $ gem install bundler
   $ bundle install
   :1
  $ bin/kitchen test [platform]

Where ``[platform]`` is the platform name defined in ``kitchen.yml``,
e.g. ``debian-9-2019-2-py3``.

``bin/kitchen converge``
^^^^^^^^^^^^^^^^^^^^^^^^

Creates the docker instance and runs the ``template`` main state, ready for testing.

``bin/kitchen verify``
^^^^^^^^^^^^^^^^^^^^^^

Runs the ``inspec`` tests on the actual instance.

``bin/kitchen destroy``
^^^^^^^^^^^^^^^^^^^^^^^

Removes the docker instance.

``bin/kitchen test``
^^^^^^^^^^^^^^^^^^^^

Runs all of the stages above in one go: i.e. ``destroy`` + ``converge`` + ``verify`` + ``destroy``.

``bin/kitchen login``
^^^^^^^^^^^^^^^^^^^^^

Gives you SSH access to the instance for manual testing.
