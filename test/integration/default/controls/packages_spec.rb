# frozen_string_literal: true

# Overide by OS
package_name = 'bash'
package_name = 'cronie' if (os[:name] == 'centos') && os[:release].start_with?('6')

control 'apache package' do
  title 'should be installed'

  package_name =
    case platform[:family]
    when 'debian', 'suse'
        'apache2'
    when 'redhat', 'fedora'
        'httpd'
    when 'arch'
        'apache'
    end

  describe package(package_name) do
    it { should be_installed }
  end
end
