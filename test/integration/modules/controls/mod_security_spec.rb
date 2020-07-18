# frozen_string_literal: true

control 'apache mod_security configuration' do
  title 'should match desired lines'

  modspec_file =
    case platform[:family]
    when 'redhat', 'fedora'
      '/etc/httpd/conf.d/mod_security.conf'
    when 'debian'
      '/etc/modsecurity/modsecurity.conf-recommended'
    end

  describe file(modspec_file) do
    it { should be_file }
    its('mode')  { should cmp '0644' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('content') { should match(/SecRuleEngine On/) }
    its('content') { should match(/SecRequestBodyAccess On/) }
    its('content') { should match(/SecRequestBodyLimit 14000000/) }
    its('content') { should match(/SecRequestBodyNoFilesLimit 114002/) }
    its('content') { should match(/SecRequestBodyInMemoryLimit 114002/) }
    its('content') { should match(/SecRequestBodyLimitAction Reject/) }
    its('content') { should match(/SecPcreMatchLimit 15000/) }
    its('content') { should match(/SecPcreMatchLimitRecursion 15000/) }
    its('content') { should match(/SecDebugLogLevel 3/) }
  end
end
