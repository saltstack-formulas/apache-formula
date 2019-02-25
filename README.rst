======
apache
======

Formulas to set up and configure the Apache HTTP server.

This Formula uses the concepts of ``directive`` and ``container`` in pillars

* ``directive`` is an httpd directive https://httpd.apache.org/docs/2.4/en/mod/directives.html
* ``container`` is what described the `configuration sections` https://httpd.apache.org/docs/2.4/en/sections.html

see examples below for more explanation

Also it includes and enforce some hardening rules to prevent security issues

See `<Hardening.md>`_ and `<apache/hardening-values.yaml>`_.

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

``apache.config-ng``
-----------------

Configures apache server.

The configuration is done by merging the pillar content with defaults
present in the state `<apache/defaults/RedHat/defaults-apache-2.4.yaml>`_

.. code:: yaml

    apache:
      server_apache_config:
        directives:
          - Timeout: 5
        containers:
          IfModule:
            -
              item: 'mime_module'
              directives:
                - AddType: 'application/x-font-ttf ttc ttf'
                - AddType: 'application/x-font-opentype otf'
                - AddType: 'application/x-font-woff woff2'


``apache.modules-ng``
------------------

Enables and disables Apache modules.

``apache.vhosts.vhost-ng``
--------------------------

Configures Apache name-based virtual hosts and creates virtual host directories using data from Pillar.

All necessary data must be provided in the pillar

Exceptions are :

* ``CustomLog`` default is ``/path/apache/log/ServerName-access.log  combined``

* if ``Logformat`` is defined in pillar, ``CustomLog`` is enforced to ``/path/apache/log/ServerName-access.log  Logformat``

* ``ErrorLog`` is enforced to ``/path/apache/log/ServerName-error.log``

Example Pillar:

Create two vhosts ``example.com.conf`` and ``test.example.com.conf``

.. code:: yaml

    apache:
      VirtualHost:
        example.com:  # <-- this is an id decalaration used in salt and default ServerName
          item: '*:80'
          directives:
            - RewriteEngine: 'on'
            - Header: 'set Access-Control-Allow-Methods GET,PUT,POST,DELETE,OPTIONS'
          containers:
            Location:
              item: '/test.html'
              directives:
                - Require: 'all granted'
        site_id_declaration:
          item: '10.10.1.1:8080'
          directives:
            - ServerName: 'test.example.com'
            - LogFormat: '"%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-agent}i\" %{ms}T"'

Files produced by these pillars :

``example.com.conf``

.. code:: bash

    <VirtualHost *:80>
      ServerName example.com
      CustomLog /var/log/httpd/example.com-access.log  combined
      ErrorLog /var/log/httpd/example.com-error.log
      RewriteEngine on
      Header set Access-Control-Allow-Methods GET,PUT,POST,DELETE,OPTIONS
      <Location /test.html>
        Require all granted
      </Location>
    </VirtualHost>


``test.example.com.conf``

.. code:: bash

    <VirtualHost 10.10.1.1:8080>
      ServerName test.example.com
      CustomLog /var/log/httpd/test.example.com-access.log "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-agent}i\" %{ms}T"
      ErrorLog /var/log/httpd/test.example.com-error.log
    </VirtualHost>



this will delete ``test.example.com.conf``

.. code:: yaml

    apache:
      VirtualHost:
        test.example.com:
          item: '10.10.1.1:8080'
          absent: True  # <-- delete test.example.com.conf
          directives:
            - ServerName: 'test.example.com'



``apache.uninstall``
----------

Stops the Apache service and uninstalls the package.
