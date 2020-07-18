# frozen_string_literal: true

control 'apache configuration' do
  title 'should match desired lines'

  describe file('/etc/apache2/apache2.conf') do
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
