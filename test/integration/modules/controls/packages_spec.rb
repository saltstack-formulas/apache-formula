# frozen_string_literal: true

control 'apache mod_security package' do
  title 'should be installed'

  package_name =
    case platform[:family]
    when 'debian', 'suse'
        'libapache2-mod-security2'
    when 'redhat', 'fedora'
        'mod_security'
    when 'suse'
        'apache2-mod_security2'
    end

  describe package(package_name) do
    it { should be_installed }
  end
end
