#
# Cookbook:: wp-cookbook
# Recipe:: mysql
#
# Copyright:: 2019, The Authors, All Rights Reserved.

yum_package %w{mariadb mariadb-server} do
    action :install
end


service 'mariadb' do
    action [:enable, :start]
end

execute 'config_mysql' do
    command <<-EOF
    mysql -uroot -e "CREATE DATABASE #{node['wp-cookbook']['wordpress_database']}";
    mysql -uroot -e "CREATE USER #{node['wp-cookbook']['wordpress_username']}@localhost IDENTIFIED BY #{node['wp-cookbook']['wordpress_password']};"
    mysql -uroot -e "GRANT ALL PRIVILEGES ON #{node['wp-cookbook']['wordpress_username']}.* TO #{node['wp-cookbook']['wordpress_username']}@localhost;"
    mysql -uroot -e "FLUSH PRIVILEGES;"
    EOF
    not_if "mysql -uroot -e 'SHOW DATABASES;' | grep #{node['wp-cookbook']['wordpress_database']}" 
    action :run
end
