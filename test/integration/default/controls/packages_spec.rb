# frozen_string_literal: true

# Overide by OS
control 'apache package' do
  title 'should be installed'

  case platform[:family]
  when 'debian'
    package_name = 'apache2'
    user_name = 'www-data'
    group_name = 'www-data'
  when 'suse'
    package_name = 'apache2'
    user_name = 'wwwrun'
    group_name = 'wwwrun'
  when 'redhat', 'fedora'
    package_name = 'httpd'
    user_name = 'apache'
    group_name = 'apache'
  when 'gentoo'
    package_name = 'www-servers/apache'
    user_name = 'apache'
    group_name = 'apache'
  when 'linux', 'arch'
    package_name = 'apache'
    user_name = 'http'
    group_name = 'http'
  when 'bsd'
    package_name = 'apache24'
    user_name = 'www'
    group_name = 'www'
  when 'windows'
    package_name = 'apache-httpd'
  end

  describe package(package_name) do
    it { should be_installed }
  end
  describe group(group_name) do
    it { should exist }
  end
  describe user(user_name) do
    it { should exist }
  end
end
