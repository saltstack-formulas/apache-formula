require_relative '../../../kitchen/data/spec_helper'

describe 'apache.mod_security' do

  case os[:family]
  when 'redhat'
    modspec_file = '/etc/httpd/conf.d/mod_security.conf'
  when 'debian', 'ubuntu'
    modspec_file = '/etc/modsecurity/modsecurity.conf-recommended'
  else
    # No other supported ATM
  end

  describe file(modspec_file) do
    it { should exist }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its(:content) { should match /SecRuleEngine On/ }
    its(:content) { should match /SecRequestBodyAccess On/ }
    its(:content) { should match /SecRequestBodyLimit 14000000/ }
    its(:content) { should match /SecRequestBodyNoFilesLimit 114002/ }
    its(:content) { should match /SecRequestBodyInMemoryLimit 114002/ }
    its(:content) { should match /SecRequestBodyLimitAction Reject/ }
    its(:content) { should match /SecPcreMatchLimit 15000/ }
    its(:content) { should match /SecPcreMatchLimitRecursion 15000/ }
    its(:content) { should match /SecDebugLogLevel 3/ }
  end
end
