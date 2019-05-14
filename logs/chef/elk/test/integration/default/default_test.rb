# InSpec test for recipe elk::default

# The InSpec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

['epel-release', 'net-tools', 'telnet', 'java-1.8.0-openjdk'].each do |p|
  describe package(p) do
    it { should be_installed}
  end
end
