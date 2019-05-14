#
# Cookbook:: elk
# Recipe:: default
#
# Copyright:: 2019, Ivan Korniienko
execute 'import_rpm_key' do
  command 'rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch'
end

yum_repository 'elasticsearch-6.x' do
  baseurl 'https://artifacts.elastic.co/packages/6.x/yum'
  description 'Elasticsearch repository for 6.x packages'
  enabled true
  gpgcheck true
  gpgkey 'https://artifacts.elastic.co/GPG-KEY-elasticsearch'
  repo_gpgcheck true
  repositoryid 'elasticsearch'
end

# install a base set of packages
['epel-release', 'net-tools', 'telnet', 'java-1.8.0-openjdk'].each do |p|
  yum_package p do
    action :install
  end
end
