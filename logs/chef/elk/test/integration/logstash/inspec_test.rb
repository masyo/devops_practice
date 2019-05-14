# InSpec test for recipe elk::logstash

# The InSpec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe systemd_service('logstash') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/logstash/conf.d/02-beats-input.conf') do
  it { should exist }
end

describe file('/etc/logstash/conf.d/10-syslog-filter.conf') do
  it { should exist }
end

describe file('/etc/logstash/conf.d/30-elasticsearch-output.conf') do
  it { should exist }
end

describe port(5044) do
  it { should be_listening }
end

describe port(9600) do
  it { should be_listening }
end