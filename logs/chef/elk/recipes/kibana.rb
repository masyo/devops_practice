# install kibana and start it
yum_package 'kibana' do
  action :install
end

service 'kibana' do
  action [ :enable, :start ]
end

template '/etc/kibana/kibana.yml' do
  mode 0644
  source 'kibana.yml.erb'
  variables(server_name: node['nginx']['server_name'], addresses: node['network']['interfaces']['eth0']['addresses'])
  notifies :restart, resources(:service => 'kibana'), :immediately
end
