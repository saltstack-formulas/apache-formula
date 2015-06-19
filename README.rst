======
apache
======

Formulas to set up and configure the Apache HTTP server.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``apache``
----------

Installs the Apache package and starts the service.

``apache.config``
-----------------

Configures apache based on os_family

``apache.mod_mpm``
------------------

Configures the apache mpm modules on Debian ``mpm_prefork``, ``mpm_worker`` or ``mpm_event`` (Debian Only)

``apache.modules``
------------------

Enables and disables Apache modules.

``apache.mod_rewrite``
----------------------

Enabled the Apache module mod_rewrite (Debian only)

``apache.mod_proxy``
-------------------

Enables the Apache module mod_proxy. (Debian only)

``apache.mod_proxy_http``
-------------------------

Enables the Apache module mod_proxy_http and requires the Apache module mod_proxy to be enabled. (Debian Only)

``apache.mod_wsgi``
-------------------

Installs the mod_wsgi package and enables the Apache module.

``apache.mod_actions``
----------------------

Enables the Apache module mod_actions. (Debian Only)

``apache.mod_headers``
----------------------

Enables the Apache module mod_headers. (Debian Only)

``apache.mod_pagespeed``
------------------------

Installs and Enables the mod_pagespeed module. (Debian Only)

``apache.mod_php5``
-------------------

Installs and enables the mod_php5 module

``apache.mod_fcgid``
--------------------

Installs and enables the mod_fcgid module

``apache.mod_vhost_alias``
----------------------

Enables the Apache module vhost_alias (Debian Only)

``apache.vhosts.standard``
--------------------------

Configures Apache name-based virtual hosts and creates virtual host directories using data from Pillar.

Example Pillar:

.. code:: yaml

    apache:
      sites:
        example.com: # must be unique; used as an ID declaration in Salt; also passed to the template context as {{ id }}
          template_file: salt://apache/vhosts/standard.tmpl


``apache.debian_full``
----------------------

Installs and configures Apache on Debian and Ubuntu systems.

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
