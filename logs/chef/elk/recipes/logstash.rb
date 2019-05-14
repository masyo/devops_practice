# install nginx and start it
yum_package 'logstash' do
  action :install
end

template '/etc/logstash/conf.d/02-beats-input.conf' do
  mode 0644
  source '02-beats-input.conf.erb'
  #notifies :restart, resources(:service => 'logstash'), :immediately
end

template '/etc/logstash/conf.d/10-syslog-filter.conf' do
  mode 0644
  source '10-syslog-filter.conf.erb'
  #notifies :restart, resources(:service => 'logstash'), :immediately
end

template '/etc/logstash/conf.d/30-elasticsearch-output.conf' do
  mode 0644
  source '10-syslog-filter.conf.erb'
  variables(addresses: node['network']['interfaces']['eth0']['addresses'])
  #notifies :restart, resources(:service => 'logstash'), :immediately
end

execute 'test_configuration' do 
  command 'sudo -u logstash /usr/share/logstash/bin/logstash --path.settings /etc/logstash -t && /root/logstash_checked' 
  not_if { ::File.exist?('/root/logstash_checked') }
end

execute 'register_systemd_service' do
  command 'sudo /usr/share/logstash/bin/system-install /etc/logstash/startup.options systemd'
  not_if 'systemctl status logstash'
end

service 'logstash' do
  action [:enable, :start]
end