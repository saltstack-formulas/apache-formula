# frozen_string_literal: true

control 'apache server_status configuration' do
  title 'should match desired lines'

  server_status_stanza = <<~SS_STANZA
    <Location "/server-status">
        SetHandler server-status
        Require local
        Require host foo.example.com
        Require ip 10.8.8.0/24
    </Location>
  SS_STANZA

  confdir =
    case system.platform[:family]
    when 'debian'
      '/etc/apache2/conf-available'
    when 'redhat', 'fedora'
      '/etc/httpd/conf.d'
    when 'suse'
      '/etc/apache2/conf.d'
    when 'arch'
      '/etc/httpd/conf/extra'
    when 'bsd'
      '/usr/local/etc/apache24/extra'
    end

  conffile, conffile_group =
    case system.platform[:family]
    when 'bsd'
      %W[#{confdir}/server-status wheel]
    else
      %W[#{confdir}/server-status.conf root]
    end

  describe file(conffile) do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into conffile_group }
    its('mode') { should cmp '0644' }
    its('content') { should include '# File managed by Salt' }
    its('content') { should include server_status_stanza }
  end
end
