#
# Cookbook:: apache
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
yum_package 'httpd' do
  action :install
end

service 'httpd' do
    action [ :enable, :start ]
end

template '/var/www/html/index.html' do
  source 'index.html.erb'
  owner 'apache'
  mode '0755'
  action :create
  variables( :servername => node['servername'])
end
