# frozen_string_literal: true

control 'apache configuration' do
  title 'should match desired lines'

  config_file =
    case platform[:family]
    when 'debian'
      '/etc/apache2/apache2.conf'
    when 'redhat', 'fedora'
      '/etc/httpd/conf/httpd.conf'
    when 'suse'
      '/etc/apache2/httpd.conf'
    # `linux` here is sufficient for `arch`
    when 'linux'
      '/etc/httpd/conf/httpd.conf'
    end
  describe file(config_file) do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('mode') { should cmp '0644' }
    its('content') do
      should include(
        'This file is managed by Salt! Do not edit by hand!'
      )
    end
  end
end
control 'apache configuration' do
  title 'should be valid'

  describe command('apachectl -t') do
    its('stdout') { should eq '' }
    its('stderr') { should include 'Syntax OK' }

    its('exit_status') { should eq 0 }
  end
end
