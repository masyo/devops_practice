# install nginx and start it
yum_package 'elasticsearch' do
  action :install
end

service 'elasticsearch' do
  action [ :enable, :start ]
end

template '/etc/elasticsearch/elasticsearch.yml' do
  mode 0644
  source 'elasticsearch.yml.erb'
  variables(addresses: node['network']['interfaces']['eth0']['addresses'])
  notifies :reload, resources(:service => 'elasticsearch'), :immediately
end
