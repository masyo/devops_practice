# install nginx and start it
['epel-release', 'nginx'].each do |p|
  yum_package p do
    action :install
  end
end

service 'nginx' do
  action [ :enable, :start ]
end

template '/etc/nginx.conf' do
  mode 0644
  source 'nginx.conf.erb'
  variables backends: {
    'ips' => node['backends']
  }
  notifies :reload, resources(:service => 'nginx'), :immediately
end