# -*- coding: utf-8 -*-
# vim: ft=yaml
---
apache:
  lookup:
    master: template-master

    # apache version (generally '2.2' or '2.4')
    # version: '2.2'

    # Default value for AddDefaultCharset in RedHat configuration
    default_charset: 'UTF-8'

    # Should we enforce DocumentRoot user/group?
    document_root_user: null   # Defaults to: apache.user
    document_root_group: null  # Defaults to: apache.group

    # Just for testing purposes
    winner: lookup
    added_in_lookup: lookup_value

  # Using bash package and udev service as an example. This allows us to
  # test the template formula itself. You should set these parameters to
  # examples that make sense in the contexto of the formula you're writing.
  # pkg:
  #   deps:
  #     mod_ssl   # redhat
  #     mod_security  # redhat
  #     mod_geoip     # redhat
  #     GeoIP  # redhat
  #     libapache2-mod-security2  # Debian

  global:
    # global apache directives
    AllowEncodedSlashes: 'On'

  name_virtual_hosts:
    - interface: '*'
      port: 80
    - interface: '*'
      port: 443

  # ``apache.vhosts`` formula additional configuration:
  # fqdn should be added to /etc/hosts i.e. ##
  # $ tail -3 /etc/hosts
  # 127.0.0.1   example.com
  # 127.0.0.1   www.redirectmatch.com
  # 127.0.0.1   www.proxyexample.com

  sites:
    example.net:
      template_file: salt://apache/config/vhosts/minimal.tmpl
      port: '8081'

    example.com:  # must be unique; used as an ID declaration in Salt.
      enabled: true
      # or minimal.tmpl or redirect.tmpl or proxy.tmpl
      template_file: salt://apache/config/vhosts/standard.tmpl

      ####################### DEFAULT VALUES BELOW ############################
      # NOTE: the values below are simply default settings that *can* be
      # overridden and are not required in order to use this formula to create
      # vhost entries.
      #
      # Do not copy the values below into your Pillar unless you intend to
      # modify these vaules.
      ####################### DEFAULT VALUES BELOW ############################
      template_engine: jinja

      interface: '*'
      port: '443'

      exclude_listen_directive: true  # Do not add a Listen directive in httpd.conf

      ServerName: example.com  # uses the unique ID above unless specified
      # ServerAlias: www.example.com  # Do not add ServerAlias unless defined

      ServerAdmin: webmaster@example.com

      LogLevel: warn
      # E.g.: /var/log/apache2/example.com-error.log
      # ErrorLog: /path/to/logs/example.com-error.log
      # E.g.: /var/log/apache2/example.com-access.log
      # CustomLog: /path/to/logs/example.com-access.log

      # E.g., /var/www/example.com
      DocumentRoot: /path/to/www/dir/example.com
      # do not enforce user, defaults to lookup:document_root_user or apache.user
      DocumentRootUser: null
      # Force group, defaults to lookup:document_root_group or apache.user
      DocumentRootGroup: null

      {%- if grains.os_family in ('Debian', 'Suse', 'Gentoo') %}
      SSLCertificateFile: /etc/apache2/conf/server.crt
      SSLCertificateKeyFile: /etc/apache2/conf/server.key
      {%- else %}
      SSLCertificateFile: /etc/httpd/conf/server.crt
      SSLCertificateKeyFile: /etc/httpd/conf/server.key
      {%- endif %}
      # SSLCertificateChainFile: /etc/httpd/ssl/example.com.cer

      SSLCertificateFile_content: |
        -----BEGIN CERTIFICATE-----
        MIIDYTCCAkkCFCKCcuwB/Ze9bI5/75oRChNH8RzHMA0GCSqGSIb3DQEBCwUAMG0x
        CzAJBgNVBAYTAklFMREwDwYDVQQIDAhDb25uYWNodDESMBAGA1UEBwwJQ29ubWFp
        Y25lMSEwHwYDVQQKDBhJbnRlcm5ldCBXaWRnaXRzIFB0eSBMdGQxFDASBgNVBAMM
        C2V4YW1wbGUuY29tMB4XDTIwMTAwMzEzMzI1N1oXDTIxMTAwMzEzMzI1N1owbTEL
        MAkGA1UEBhMCSUUxETAPBgNVBAgMCENvbm5hY2h0MRIwEAYDVQQHDAlDb25tYWlj
        bmUxITAfBgNVBAoMGEludGVybmV0IFdpZGdpdHMgUHR5IEx0ZDEUMBIGA1UEAwwL
        ZXhhbXBsZS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDSl0qL
        ol+/b3R9VccpOLe5Cg1Tf1zstAzV5TvjcjSdytdwMDGy9J8Yi2EcMZ1wNdMkvf4D
        mr+72Za+qeHHc0ZA+fIJoV+tTcbLbV/mhv0i0i7Zldi3QuvIVBpLR2Z5s5mXZ7C8
        yz8VpF9enQkS3uNnbNuZNT3ElGHmlAj1yHsh0K+TbvZrygFkG0wvYwivhlt1Zcbo
        th4LJ+gBwNIdSJUiAa58VO5ZNeenM9DquJfZVcFc1bDFqzU0T9KY4PsxmzO1A2+m
        TDHoGR4nCz7B+5Ec4USyBUuKo2FhALBEtYz2hlwaf9XasSSvmzO5hhPCQ3nJ4qeY
        i+BLCSpiq2lApPVZAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAD9/78A4ygQWbO27
        jQPm+2Zg0f9Sn1tcD4tOVao0MlAfWrALjbmj82hg+givEQKAuN7ptthYoaJcOxHl
        aUe++y3bQiCznN73yKSJZFgG5fYR8tyMslsYRBcKSay0nvPhN/3Jry0nNehDREQ+
        2H0vB595bymGNTmux13sNwOZH1i8KEgxdLcFbje87+CbhCGbFhS3lHPY2FeXnHpO
        W60Zchwsy06xMjo4rzbQatdJj/HAh6lIx0YmNDX/d3dCLpZlkvUBT6ENVhipi5bb
        2pF/Awob8AYWbIn4N7gmIP5Sb0tugpEgrSgSyDdZNWoFDChvfHXcNUP8lblIftAl
        ylssbnQ=
        -----END CERTIFICATE-----

      SSLCertificateKeyFile_content: |
        -----BEGIN RSA PRIVATE KEY-----
        MIIEowIBAAKCAQEA0pdKi6Jfv290fVXHKTi3uQoNU39c7LQM1eU743I0ncrXcDAx
        svSfGIthHDGdcDXTJL3+A5q/u9mWvqnhx3NGQPnyCaFfrU3Gy21f5ob9ItIu2ZXY
        t0LryFQaS0dmebOZl2ewvMs/FaRfXp0JEt7jZ2zbmTU9xJRh5pQI9ch7IdCvk272
        a8oBZBtML2MIr4ZbdWXG6LYeCyfoAcDSHUiVIgGufFTuWTXnpzPQ6riX2VXBXNWw
        xas1NE/SmOD7MZsztQNvpkwx6BkeJws+wfuRHOFEsgVLiqNhYQCwRLWM9oZcGn/V
        2rEkr5szuYYTwkN5yeKnmIvgSwkqYqtpQKT1WQIDAQABAoIBAQCI39SP1UWuQ17P
        Z8U+waKIHkRzFMDtCEmfbJL0TfJs7L4CKRDkY6JUbaL8lDLkD9fgdax340jja5VS
        70/UNtRevxXVtJFfLsIazkgaqXo1+65/talZ06E0X5WHgCzWxSj7A2YYD3I9OszR
        zfdr0Hq1akeA2N4AuwC2wVjhhyCg5Lg4xY0l+kRFLrPU4RctsjCAaveVIm3wmJVd
        vmHO9hKcR3nxuIx0/cPYe20WgGSqbYJQburE1uXp26uz/Jek/u8FNFIEjWCWB+vj
        eRQOcxngebyWCh0dyoxb3nL28Yty9O1MlLP2b0YMmep1ZfEFtwn4M2d8FdW1WCmJ
        viOGFx4BAoGBAPTYSIpyxea1qaeNmT97e4YgPwV3rajhdPRYSQKyCsjKHk7Q/uxk
        Phddo0ymiGKLCRAUwg9py900slY8mZKbdrVxXV4EEhngrWrr2gpfzxkEF1i0d4bS
        2OuRCbkfE23glxqtVjvnTlrRANaXgk5mUQCL1YDUf+hrpEvF0pTbDRYpAoGBANwv
        ffy+Sk+e0v+NlthhNHUDcXisIoW7b/DoT0H8DtbJV/QVexaGln7Ts6EgaH2NdpC+
        dyLKa+l7oIeKgXeHm2Tgm879di/ChQCkoAHIUu5Nm0c5D2Vst26JrfCA7vZb9ddI
        FMFt5bsDgRqFzTXFe0k9TEIBiF0Pp5xfHVwNWeuxAoGAGNY3xZOO77BN3WlHumDU
        Tu7Gdc+GFjOIoaCzB0r4PRYDrQsWUPR6N/SPtB7Qhu6DpNX2OYoJ3A6UaJsNGQoc
        KJuvVPIkw+s+rDHwlEzTvT3lAGKOHWcWCg9UZSr51ZOKwHIE5V65XA0HgL0twrYu
        UVfd+IuVzgXdTLJsgh0WXsECgYApcgcU+/yg4BR3Zf9u2100aWGChWQ6J/36KsBA
        e2GPrHaRyzlQFCVf2hmFysPgXjBjLnbeZZvKZyrgWIHmLfBiHKU3YR5N/x9p75Lu
        wvZZROJllagAP2aHuAK1so9IcCbmTvsZLcaAXTh/9Y+a/4ElWBRymDdCzR+Pn5e3
        LAwxAQKBgBHH42ri6pHbRptINzJ9sw3PhwewQZtGu3sfvrOknBs3togptCrjBWDF
        eOGuFmjHO9vnhWs2yWQYETL1jt+CWgzRc4o4akB3qH5sXar5F7h06y16RFV9u6UJ
        qaGqPFcy/l/5H6uNPLZt4Ufg3T0Mz0Az+Dti99KqVLKeqWQvXVc4
        -----END RSA PRIVATE KEY-----


      Directory:
        # "default" is a special case; uses DocumentRoot value
        # E.g.: /var/www/example.com
        default:
          Options: -Indexes +FollowSymLinks
          Order: allow,deny     # For Apache < 2.4
          Allow: from all       # For apache < 2.4
          Require: all granted  # For apache > 2.4.
          AllowOverride: None
          # Formula_Append: |
          #   Additional config as a
          #   multi-line string here

    # Force SSL: Redirect from 80 to 443
    example2.com:
      port: 80
      template_file: salt://apache/vhosts/redirect.tmpl
      RedirectSource: 'permanent /'
      # Trailing slash is important
      RedirectTarget: 'https://example.com/'
    example2.com_ssl:
      port: 443
      ServerName: example.com
      SSLCertificateFile: /path/to/ssl.crt
      SSLCertificateKeyFile: /path/to/ssl.key
      SSLCertificateChainFile: /path/to/ssl.ca.crt

    # Use RedirectMatch Directive
    redirectmatch.com:
      # - https://httpd.apache.org/docs/2.4/fr/mod/mod_alias.html#redirectmatch
      # Require module mod_alias
      enabled: true
      template_file: salt://apache/config/vhosts/redirect.tmpl
      ServerName: www.redirectmatch.com
      ServerAlias: www.redirectmatch.com
      RedirectMatch: true
      RedirectSource: '^/$'
      RedirectTarget: '/subdirectory'
      DocumentRoot: /var/www/html/
      port: '8083'

    8084-proxyexample.com:
      template_file: salt://apache/config/vhosts/redirect.tmpl
      ServerName: www.proxyexample.com
      ServerAlias: www.proxyexample.com
      RedirectSource: '/'
      RedirectTarget: 'https://www.proxyexample.com/'
      DocumentRoot: /var/www/proxy
      port: '8084'

    8443-proxyexample.com:
      template_file: salt://apache/config/vhosts/proxy.tmpl
      ServerName: www.proxyexample.com
      ServerAlias: www.proxyexample.com
      interface: '*'
      port: '8443'
      DocumentRoot: /var/www/proxy

      Rewrite: |
        RewriteRule ^/webmail$ /webmail/ [R]
        RewriteRule ^/webmail(.*) http://mail.example.com$1 [P,L]
        RewriteRule ^/vicescws(.*) http://svc.example.com:92$1 [P,L]

      SSLCertificateFile: /etc/httpd/conf/server.crt
      SSLCertificateKeyFile: /etc/httpd/conf/server.key
      # SSLCertificateChainFile: /etc/httpd/ssl/example.com.cer

      SSLCertificateFile_content: |
        -----BEGIN CERTIFICATE-----
        MIIDYTCCAkkCFCKCcuwB/Ze9bI5/75oRChNH8RzHMA0GCSqGSIb3DQEBCwUAMG0x
        CzAJBgNVBAYTAklFMREwDwYDVQQIDAhDb25uYWNodDESMBAGA1UEBwwJQ29ubWFp
        Y25lMSEwHwYDVQQKDBhJbnRlcm5ldCBXaWRnaXRzIFB0eSBMdGQxFDASBgNVBAMM
        C2V4YW1wbGUuY29tMB4XDTIwMTAwMzEzMzI1N1oXDTIxMTAwMzEzMzI1N1owbTEL
        MAkGA1UEBhMCSUUxETAPBgNVBAgMCENvbm5hY2h0MRIwEAYDVQQHDAlDb25tYWlj
        bmUxITAfBgNVBAoMGEludGVybmV0IFdpZGdpdHMgUHR5IEx0ZDEUMBIGA1UEAwwL
        ZXhhbXBsZS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDSl0qL
        ol+/b3R9VccpOLe5Cg1Tf1zstAzV5TvjcjSdytdwMDGy9J8Yi2EcMZ1wNdMkvf4D
        mr+72Za+qeHHc0ZA+fIJoV+tTcbLbV/mhv0i0i7Zldi3QuvIVBpLR2Z5s5mXZ7C8
        yz8VpF9enQkS3uNnbNuZNT3ElGHmlAj1yHsh0K+TbvZrygFkG0wvYwivhlt1Zcbo
        th4LJ+gBwNIdSJUiAa58VO5ZNeenM9DquJfZVcFc1bDFqzU0T9KY4PsxmzO1A2+m
        TDHoGR4nCz7B+5Ec4USyBUuKo2FhALBEtYz2hlwaf9XasSSvmzO5hhPCQ3nJ4qeY
        i+BLCSpiq2lApPVZAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAD9/78A4ygQWbO27
        jQPm+2Zg0f9Sn1tcD4tOVao0MlAfWrALjbmj82hg+givEQKAuN7ptthYoaJcOxHl
        aUe++y3bQiCznN73yKSJZFgG5fYR8tyMslsYRBcKSay0nvPhN/3Jry0nNehDREQ+
        2H0vB595bymGNTmux13sNwOZH1i8KEgxdLcFbje87+CbhCGbFhS3lHPY2FeXnHpO
        W60Zchwsy06xMjo4rzbQatdJj/HAh6lIx0YmNDX/d3dCLpZlkvUBT6ENVhipi5bb
        2pF/Awob8AYWbIn4N7gmIP5Sb0tugpEgrSgSyDdZNWoFDChvfHXcNUP8lblIftAl
        ylssbnQ=
        -----END CERTIFICATE-----

      SSLCertificateKeyFile_content: |
        -----BEGIN RSA PRIVATE KEY-----
        MIIEowIBAAKCAQEA0pdKi6Jfv290fVXHKTi3uQoNU39c7LQM1eU743I0ncrXcDAx
        svSfGIthHDGdcDXTJL3+A5q/u9mWvqnhx3NGQPnyCaFfrU3Gy21f5ob9ItIu2ZXY
        t0LryFQaS0dmebOZl2ewvMs/FaRfXp0JEt7jZ2zbmTU9xJRh5pQI9ch7IdCvk272
        a8oBZBtML2MIr4ZbdWXG6LYeCyfoAcDSHUiVIgGufFTuWTXnpzPQ6riX2VXBXNWw
        xas1NE/SmOD7MZsztQNvpkwx6BkeJws+wfuRHOFEsgVLiqNhYQCwRLWM9oZcGn/V
        2rEkr5szuYYTwkN5yeKnmIvgSwkqYqtpQKT1WQIDAQABAoIBAQCI39SP1UWuQ17P
        Z8U+waKIHkRzFMDtCEmfbJL0TfJs7L4CKRDkY6JUbaL8lDLkD9fgdax340jja5VS
        70/UNtRevxXVtJFfLsIazkgaqXo1+65/talZ06E0X5WHgCzWxSj7A2YYD3I9OszR
        zfdr0Hq1akeA2N4AuwC2wVjhhyCg5Lg4xY0l+kRFLrPU4RctsjCAaveVIm3wmJVd
        vmHO9hKcR3nxuIx0/cPYe20WgGSqbYJQburE1uXp26uz/Jek/u8FNFIEjWCWB+vj
        eRQOcxngebyWCh0dyoxb3nL28Yty9O1MlLP2b0YMmep1ZfEFtwn4M2d8FdW1WCmJ
        viOGFx4BAoGBAPTYSIpyxea1qaeNmT97e4YgPwV3rajhdPRYSQKyCsjKHk7Q/uxk
        Phddo0ymiGKLCRAUwg9py900slY8mZKbdrVxXV4EEhngrWrr2gpfzxkEF1i0d4bS
        2OuRCbkfE23glxqtVjvnTlrRANaXgk5mUQCL1YDUf+hrpEvF0pTbDRYpAoGBANwv
        ffy+Sk+e0v+NlthhNHUDcXisIoW7b/DoT0H8DtbJV/QVexaGln7Ts6EgaH2NdpC+
        dyLKa+l7oIeKgXeHm2Tgm879di/ChQCkoAHIUu5Nm0c5D2Vst26JrfCA7vZb9ddI
        FMFt5bsDgRqFzTXFe0k9TEIBiF0Pp5xfHVwNWeuxAoGAGNY3xZOO77BN3WlHumDU
        Tu7Gdc+GFjOIoaCzB0r4PRYDrQsWUPR6N/SPtB7Qhu6DpNX2OYoJ3A6UaJsNGQoc
        KJuvVPIkw+s+rDHwlEzTvT3lAGKOHWcWCg9UZSr51ZOKwHIE5V65XA0HgL0twrYu
        UVfd+IuVzgXdTLJsgh0WXsECgYApcgcU+/yg4BR3Zf9u2100aWGChWQ6J/36KsBA
        e2GPrHaRyzlQFCVf2hmFysPgXjBjLnbeZZvKZyrgWIHmLfBiHKU3YR5N/x9p75Lu
        wvZZROJllagAP2aHuAK1so9IcCbmTvsZLcaAXTh/9Y+a/4ElWBRymDdCzR+Pn5e3
        LAwxAQKBgBHH42ri6pHbRptINzJ9sw3PhwewQZtGu3sfvrOknBs3togptCrjBWDF
        eOGuFmjHO9vnhWs2yWQYETL1jt+CWgzRc4o4akB3qH5sXar5F7h06y16RFV9u6UJ
        qaGqPFcy/l/5H6uNPLZt4Ufg3T0Mz0Az+Dti99KqVLKeqWQvXVc4
        -----END RSA PRIVATE KEY-----

      SSLCertificateChainFile_content: |
        -----BEGIN CERTIFICATE-----
        MIICUTCCAfugAwIBAgIBADANBgkqhkiG9w0BAQQFADBXMQswCQYDVQQGEwJDTjEL
        MAkGA1UECBMCUE4xCzAJBgNVBAcTAkNOMQswCQYDVQQKEwJPTjELMAkGA1UECxMC
        VU4xFDASBgNVBAMTC0hlcm9uZyBZYW5nMB4XDTA1MDcxNTIxMTk0N1oXDTA1MDgx
        NDIxMTk0N1owVzELMAkGA1UEBhMCQ04xCzAJBgNVBAgTAlBOMQswCQYDVQQHEwJD
        TjELMAkGA1UEChMCT04xCzAJBgNVBAsTAlVOMRQwEgYDVQQDEwtIZXJvbmcgWWFu
        ZzBcMA0GCSqGSIb3DQEBAQUAA0sAMEgCQQCp5hnG7ogBhtlynpOS21cBewKE/B7j
        V14qeyslnr26xZUsSVko36ZnhiaO/zbMOoRcKK9vEcgMtcLFuQTWDl3RAgMBAAGj
        gbEwga4wHQYDVR0OBBYEFFXI70krXeQDxZgbaCQoR4jUDncEMH8GA1UdIwR4MHaA
        FFXI70krXeQDxZgbaCQoR4jUDncEoVukWTBXMQswCQYDVQQGEwJDTjELMAkGA1UE
        CBMCUE4xCzAJBgNVBAcTAkNOMQswCQYDVQQKEwJPTjELMAkGA1UECxMCVU4xFDAS
        BgNVBAMTC0hlcm9uZyBZYW5nggEAMAwGA1UdEwQFMAMBAf8wDQYJKoZIhvcNAQEE
        BQADQQA/ugzBrjjK9jcWnDVfGHlk3icNRq0oV7Ri32z/+HQX67aRfgZu7KWdI+Ju
        Wm7DCfrPNGVwFWUQOmsPue9rZBgO
        -----END CERTIFICATE-----
        -----BEGIN CERTIFICATE-----
        MIICUTCCAfugAwIBAgIBADANBgkqhkiG9w0BAQQFADBXMQswCQYDVQQGEwJDTjEL
        MAkGA1UECBMCUE4xCzAJBgNVBAcTAkNOMQswCQYDVQQKEwJPTjELMAkGA1UECxMC
        VU4xFDASBgNVBAMTC0hlcm9uZyBZYW5nMB4XDTA1MDcxNTIxMTk0N1oXDTA1MDgx
        NDIxMTk0N1owVzELMAkGA1UEBhMCQ04xCzAJBgNVBAgTAlBOMQswCQYDVQQHEwJD
        TjELMAkGA1UEChMCT04xCzAJBgNVBAsTAlVOMRQwEgYDVQQDEwtIZXJvbmcgWWFu
        ZzBcMA0GCSqGSIb3DQEBAQUAA0sAMEgCQQCp5hnG7ogBhtlynpOS21cBewKE/B7j
        V14qeyslnr26xZUsSVko36ZnhiaO/zbMOoRcKK9vEcgMtcLFuQTWDl3RAgMBAAGj
        gbEwga4wHQYDVR0OBBYEFFXI70krXeQDxZgbaCQoR4jUDncEMH8GA1UdIwR4MHaA
        FFXI70krXeQDxZgbaCQoR4jUDncEoVukWTBXMQswCQYDVQQGEwJDTjELMAkGA1UE
        CBMCUE4xCzAJBgNVBAcTAkNOMQswCQYDVQQKEwJPTjELMAkGA1UECxMCVU4xFDAS
        BgNVBAMTC0hlcm9uZyBZYW5nggEAMAwGA1UdEwQFMAMBAf8wDQYJKoZIhvcNAQEE
        BQADQQA/ugzBrjjK9jcWnDVfGHlk3icNRq0oV7Ri32z/+HQX67aRfgZu7KWdI+Ju
        Wm7DCfrPNGVwFWUQOmsPue9rZBgO
        -----END CERTIFICATE-----

      ProxyRequests: 'Off'
      ProxyPreserveHost: 'On'

      ProxyRoute:
        example prod proxy route:
          ProxyPassSource: '/'
          ProxyPassTarget: 'http://prod.example.com:85/'
          ProxyPassTargetOptions: 'connectiontimeout=10 timeout=90'
          ProxyPassReverseSource: '/'
          ProxyPassReverseTarget: 'http://prod.example.com:85/'

        example webmail proxy route:
          ProxyPassSource: '/webmail/'
          ProxyPassTarget: 'http://mail.example.com/'
          ProxyPassTargetOptions: 'connectiontimeout=10 timeout=90'
          ProxyPassReverseSource: '/webmail/'
          ProxyPassReverseTarget: 'http://mail.example.com/'

        example service proxy route:
          ProxyPassSource: '/svc/'
          ProxyPassTarget: 'http://svc.example.com:92/'
          ProxyPassTargetOptions: 'connectiontimeout=10 timeout=90'
          ProxyPassReverseSource: '/svc/'
          ProxyPassReverseTarget: 'http://svc.example.com:92/'

      Location:
        /:
          Require: false
          # Formula_Append: |
          #   SecRuleRemoveById 981231
          #   SecRuleRemoveById 981173

        /error:
          Require: 'all granted'

        /docs:
          Order: allow,deny     # For Apache < 2.4
          Allow: from all       # For apache < 2.4
          Require: all granted  # For apache > 2.4.
          # Formula_Append: |
          #   Additional config as a
          #   multi-line string here

      LocationMatch:
        '^[.\\/]+([Ww][Ee][Bb][Mm][Aa][Ii][Ll])[.\\/]':
          Require: false
          Formula_Append: |
            RequestHeader  set  Host  mail.example.com

        '^[.\\/]+([Ss][Vv][Cc])[.\\/]':
          Require: false
          Formula_Append: |
            Require ip 123.123.13.6 84.24.25.74

      Proxy_control:
        '*':
          AllowAll: false
          AllowCountry: false
          #   - DE
          AllowIP:
            - 12.5.25.32
            - 12.5.25.33

      Alias:
        /docs: /usr/share/docs

      ScriptAlias:
        /cgi-bin/: /var/www/cgi-bin/

        # Formula_Append: |
        #   \#Additional config as a
        #   \#multi-line string here

  # ``apache.debian_full`` formula additional configuration:
  register-site:
    # any name as an array index, and you can duplicate this section
    unique_value_here:
      name: 'myname'
      path: 'salt://apache/files/myname.conf'
      state: 'enabled'
      # Optional - use managed file as Jinja Template
      # template: true
      # defaults:
      #   custom_var: "default value"

  modules:
    enabled:   # List modules to enable
      - ssl
      - prefork
      - rewrite
      - proxy
      - proxy_ajp
      - proxy_html
      - headers
      # geoip
      - status
      - logio
      - dav
      - dav_fs
      - dav_lock
      - auth_digest
      - socache_shmcb
      - watchdog
      - xml2enc
      - ldap
    disabled:  # List modules to disable
      - geoip

  flags:
    enabled:   # List server flags to enable
      - SSL
    disabled:  # List server flags to disable
      - status

  # KeepAlive: Whether or not to allow persistent connections (more than
  # one request per connection). Set to "Off" to deactivate.
  keepalive: 'On'

  TimeOut: 60  # software default is 60 seconds

  security:
    # can be Full | OS | Minimal | Minor | Major | Prod
    # where Full conveys the most information, and Prod the least.
    ServerTokens: Prod

  # [debian only] configure mod_ssl
  ssl:
    SSLCipherSuite: 'HIGH:!aNULL'
    SSLHonorCipherOrder: 'Off'
    SSLProtocol: 'all -SSLv3'
    SSLUseStapling: 'Off'
    SSLStaplingResponderTimeout: '5'
    SSLStaplingReturnResponderErrors: 'Off'
    SSLStaplingCache: 'shmcb:/var/run/ocsp(128000)'

  # ``apache.mod_remoteip`` formula additional configuration:
  mod_remoteip:
    RemoteIPHeader: X-Forwarded-For
    RemoteIPTrustedProxy:
      - 10.0.8.0/24
      - 127.0.0.1
    RemoteIPInternalProxy:
      - 10.10.8.0/24
      - 127.0.0.1

  # ``apache.mod_security`` formula additional configuration:
  mod_security:
    crs_install: false
    # If not set, default distro's configuration is installed as is
    manage_config: true
    sec_rule_engine: 'On'
    sec_request_body_access: 'On'
    sec_request_body_limit: '14000000'
    sec_request_body_no_files_limit: '114002'
    sec_request_body_in_memory_limit: '114002'
    sec_request_body_limit_action: 'Reject'
    sec_pcre_match_limit: '15000'
    sec_pcre_match_limit_recursion: '15000'
    sec_debug_log_level: '3'

    rules:
      enabled: ~
      modsecurity_crs_10_setup.conf:
        rule_set: ''
        enabled: true
      modsecurity_crs_20_protocol_violations.conf:
        rule_set: 'base_rules'
        enabled: false

    custom_rule_files:
      # any name as an array index, and you can duplicate this section
      UNIQUE_VALUE_HERE:
        file: 'myname'
        # path/to/modsecurity/custom/file
        path: 'salt://apache/files/dummy.conf'
        enabled: false

  mod_ssl:
    # set this to true if you want to override your distributions default TLS
    # configuration
    manage_tls_defaults: false
    # This stuff is deliberately not configured via map.jinja resp.
    # apache:lookup.  We're unable to know sane defaults for each release of
    # every distribution.
    # See https://github.com/saltstack-formulas/openssh-formula/issues/102 for
    # a related discussion Have a look at bettercrypto.org for up-to-date
    # settings.
    # These are default values:
    # yamllint disable-line rule:line-length
    SSLCipherSuite: EDH+CAMELLIA:EDH+aRSA:EECDH+aRSA+AESGCM:EECDH+aRSA+SHA384:EECDH+aRSA+SHA256:EECDH:+CAMELLIA256:+AES256:+CAMELLIA128:+AES128:+SSLv3:!aNULL:!eNULL:!LOW:!3DES:!MD5:!EXP:!PSK:!DSS:!RC4:!SEED:!ECDSA:CAMELLIA256-SHA:AES256-SHA:CAMELLIA128-SHA:AES128-SHA
    # Mitigate the CRIME attack
    SSLCompression: 'Off'
    SSLProtocol: all -SSLv2 -SSLv3 -TLSv1
    SSLHonorCipherOrder: 'On'
    SSLOptions: "+StrictRequire"
  server_status_require:
    ip:
      - 10.8.8.0/24
    host:
      - foo.example.com

  tofs:
    # The files_switch key serves as a selector for alternative
    # directories under the formula files directory. See TOFS pattern
    # doc for more info.
    # Note: Any value not evaluated by `config.get` will be used literally.
    # This can be used to set custom paths, as many levels deep as required.
    files_switch:
      - any/path/can/be/used/here
      - id
      - roles
      - osfinger
      - os
      - os_family
    # All aspects of path/file resolution are customisable using the options below.
    # This is unnecessary in most cases; there are sensible defaults.
    # Default path: salt://< path_prefix >/< dirs.files >/< dirs.default >
    #         I.e.: salt://apache/files/default
    # path_prefix: template_alt
    # dirs:
    #   files: files_alt
    #   default: default_alt
    # The entries under `source_files` are prepended to the default source files
    # given for the state
    # source_files:
    #   apache-config-file-file-managed:
    #     - 'example_alt.tmpl'
    #     - 'example_alt.tmpl.jinja'

    # For testing purposes
    source_files:
      apache-config-file-file-managed:
        - 'example.tmpl.jinja'
      apache-subcomponent-config-file-file-managed:
        - 'subcomponent-example.tmpl.jinja'

  # Just for testing purposes
  winner: pillar
  added_in_pillar: pillar_value
