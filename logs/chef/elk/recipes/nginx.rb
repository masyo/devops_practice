# install nginx and start it
yum_package 'nginx' do
  action :install
end

service 'nginx' do
  action [ :enable, :start ]
end

template '/etc/nginx/conf.d/elk.conf' do
  mode 0644
  source 'nginx.conf.erb'
  variables(server_name: node['nginx']['server_name'])
  notifies :reload, resources(:service => 'nginx'), :immediately
end

# htaut is required for htpasswd
gem_package 'htauth' do
  gem_binary Chef::Util::PathHelper.join(Chef::Config.embedded_dir,'bin','gem')
  action :install
end

# creating password for accesing kibana trough nginx
htpasswd "/etc/nginx/htpassword" do
  user node['nginx']['kibana_user']
  password node['nginx']['kibana_pass']
end

execute 'selinux_enable_proxy' do
  command 'setsebool httpd_can_network_connect 1 -P'
end