# InSpec test for recipe elk::default

# The InSpec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe systemd_service('nginx') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/nginx/htpassword') do
  it { should exist }
end

# This is an example test, replace it with your own test.
describe port(80) do
  it { should be_listening }
end