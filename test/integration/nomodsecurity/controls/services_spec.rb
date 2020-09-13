# frozen_string_literal: true

# Overide by OS
control 'apache service' do
  impact 0.5
  title 'should be running and enabled'

  service_name =
    case platform[:family]
    when 'debian', 'suse'
      'apache2'
    when 'redhat', 'fedora', 'linux'
      'httpd'
    when 'gentoo'
      'www-servers/apache'
    when 'bsd'
      'apache24'
    when 'windows'
      'apache'
    end

  describe service(service_name) do
    it { should be_enabled }
    it { should be_running }
  end
end
