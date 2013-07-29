apache
======
DEPENDENCIES:
  These salt-states are required:
	1) apt

POSSIBLE DEPENDENCIES
  These salt-states may be required depending on what your doing:
	1) php

ORDERING:

The ordering of the states for apache falls into block ranges which are:
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

PILLARS:

	1)  No pillar data is required
	2)  Full pillar structure:

apache:
  php-ini: 'salt://path/to/file/php.ini'
  register-site:
    {{UNQIUE}}:
      name: 'my name'
      path: 'salt://path/to/sites-available/conf/file'
      state: 'enabled'

	3)  UNIQUE can be any name as an array index, and you can duplicate this section
