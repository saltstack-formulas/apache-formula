apache
======

Formulas to set up and configure the Apache HTTP server

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/topics/conventions/formulas.html>`_.

Available states
----------------

``apache``
    Installs the Apache package and starts the service.
``apache.debian_full``
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

    Dependencies:

    * `apt <https://github.com/saltstack-formulas/apt-formula>`_

    Optional dependencies:

    1) `php <https://github.com/saltstack-formulas/php-formula>`_

