#
# Cookbook:: wp-cookbook
# Recipe:: wp
#
# Copyright:: 2019, The Authors, All Rights Reserved.

ruby_block "wordpress" do
    block do
      require 'fileutils'
      FileUtils.cd node['wp-cookbook']['document_root']
      system 'curl -o latest.tar.gz https://wordpress.org/latest.tar.gz'
      system 'tar xzvf latest.tar.gz --strip-components=1 && rm latest.tar.gz'
      system 'chown -R apache:apache *'
    end
    not_if { ::File.exist?(File.join(node['wp-cookbook']['document_root'], 'wp-settings.php')) }
    action :create
end

file '/var/www/html/wp-config.php' do
  action :create
end

template '/var/www/html/wp-config.php' do
  source 'wp-config.php.erb'
end

service 'httpd' do
  action :restart
end
