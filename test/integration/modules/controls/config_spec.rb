# frozen_string_literal: true

control 'apache configuration' do
  title 'should match desired lines'

  apachectl = 'apachectl -t'
  case platform[:family]
  when 'debian'
    vhostdir = '/etc/apache2/sites-available'
    logrotatedir = '/etc/logrotate.d/apache2'
    logdir = '/var/log/apache2'
    moddir = '/etc/apache2/mods-enabled'
    sitesdir = '/etc/apache2/sites-enabled'
  when 'suse'
    vhostdir = '/etc/apache2/vhosts.d'
    logrotatedir = '/etc/logrotate.d/apache2'
    logdir = '/var/log/apache2'
    moddir = '/etc/apache2/mods-enabled'
    sitesdir = '/etc/apache2/vhosts.d'
  when 'redhat', 'fedora'
    vhostdir = '/etc/httpd/conf.d'
    logrotatedir = '/etc/logrotate.d/httpd'
    logdir = '/var/log/httpd'
    moddir = '/etc/httpd/conf.modules.d'
    sitesdir = '/etc/httpd/conf.d'
    apachectl = 'httpd -t'
  when 'gentoo'
    vhostdir = '/etc/apache2/vhosts.d'
    logrotatedir = '/etc/logrotate.d/apache2'
    logdir = '/var/log/apache2'
    moddir = '/etc/apache2/mods-enabled'
    sitesdir = '/etc/apache2/sites-enabled'
    # `linux` here is sufficient for `arch`
  when 'linux', 'arch'
    vhostdir = '/etc/httpd/conf/vhosts'
    logrotatedir = '/etc/logrotate.d/httpd'
    logdir = '/var/log/httpd'
    moddir = '/etc/httpd/conf.modules.d'
    sitesdir = '/etc/httpd/sites-enabled'
  when 'bsd'
    vhostdir = '/usr/local/etc/apache24/Includes'
    logdir = '/var/log'
    logrotatedir = '/usr/local/etc/logrotate.d/apache2'
    moddir = '/usr/local/etc/apache24/modules.d'
    # https://docs.freebsd.org/en/books/handbook/network-servers/#_virtual_hosting
    # All done under `/usr/local/etc/apache24/httpd.conf`
    sitesdir = '/usr/local/etc/apache24'
  end
  describe command(apachectl) do
    its('stdout') { should eq '' }
    its('stderr') { should include 'Syntax OK' }
    its('exit_status') { should eq 0 }
  end
  describe file(vhostdir) do
    it { should exist }
    it { should be_directory }
    its('type') { should eq :directory }
  end
  describe file(logrotatedir) do
    it { should exist }
    its('type') { should eq :file }
  end
  describe file(logdir) do
    it { should exist }
    it { should be_directory }
    its('type') { should eq :directory }
  end
  describe file(moddir) do
    it { should exist }
    it { should be_directory }
    its('type') { should eq :directory }
  end
  describe file(sitesdir) do
    it { should exist }
    it { should be_directory }
    its('type') { should eq :directory }
  end
end

control 'apache configuration (unique)' do
  title 'should match desired lines'

  config_file_group = 'root'
  case platform[:family]
  when 'debian'
    config_file = '/etc/apache2/apache2.conf'
    wwwdir = '/srv'
  when 'suse'
    config_file = '/etc/apache2/httpd.conf'
    wwwdir = '/srv/www'
  when 'redhat', 'fedora'
    config_file = '/etc/httpd/conf/httpd.conf'
    wwwdir = '/var/www'
  when 'gentoo'
    config_file = '/etc/apache2/httpd.conf'
    wwwdir = '/var/www'
  when 'linux', 'arch'
    config_file = '/etc/httpd/conf/httpd.conf'
    wwwdir = '/srv/http'
  when 'bsd'
    config_file = '/usr/local/etc/apache24/httpd.conf'
    config_file_group = 'wheel'
    wwwdir = '/usr/local/www/apache24/'
  end
  describe file(config_file) do
    it { should be_file }
    it { should be_grouped_into config_file_group }
    its('mode') { should cmp '0644' }
    its('content') do
      should include(
        'This file is managed by Salt! Do not edit by hand!'
      )
    end
  end
  describe file(wwwdir) do
    it { should exist }
    it { should be_directory }
    its('type') { should eq :directory }
  end
end
