# frozen_string_literal: true

control 'apache service' do
  impact 0.5
  title 'should be running and enabled'

  service_name =
    case platform[:family]
    when 'debian', 'suse'
      'apache2'
    when 'redhat', 'fedora', 'linux'
      'httpd'
    end

  describe service(service_name) do
    it { should be_enabled }
    it { should_not be_running }
  end
end
