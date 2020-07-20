# frozen_string_literal: true

control 'apache package' do
  title 'should be installed'

  package_name =
    case platform[:family]
    when 'debian', 'suse'
      'apache2'
    when 'redhat', 'fedora'
      'httpd'
    # `linux` here is sufficient for `arch`
    when 'linux'
      'apache'
    end

  describe package(package_name) do
    it { should be_installed }
  end
end
