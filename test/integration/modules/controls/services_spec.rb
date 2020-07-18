# frozen_string_literal: true

# Overide by OS
service_name = 'apache2'
service_name = 'httpd' if (os[:name] == 'centos')

control 'apache service' do
  impact 0.5
  title 'should be running and enabled'

  describe service(service_name) do
    it { should be_enabled }
    it { should_not be_running }
  end
end
