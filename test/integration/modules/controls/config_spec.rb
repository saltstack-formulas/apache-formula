# frozen_string_literal: true

control 'apache configuration' do
  title 'should be valid'

  describe command('apachectl -t') do
    its('stdout') { should eq '' }
    its('stderr') { should include 'Syntax OK' }

    its('exit_status') { should eq 0 }
  end
end
