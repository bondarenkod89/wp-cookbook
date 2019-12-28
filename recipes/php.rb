#
# Cookbook:: wp-cookbook
# Recipe:: php
#
# Copyright:: 2019, The Authors, All Rights Reserved.

execute 'php7.2' do
    command <<-EOF
    yum update -y && yum upgrade -y
    yum install epel-release yum-utils -y
    yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
    yum-config-manager --enable remi-php72 -y
    EOF
end

yum_package %w{php php-fpm php-mysql php-xmlrpc php-gd php-pear php-pspell} do
  action :install
  notifies :restart, 'service[httpd]', :immediately
end
