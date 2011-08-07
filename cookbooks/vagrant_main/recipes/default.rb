node[:apache][:listen_ports] = ["80","443"]

require_recipe "apt"
require_recipe "apache2"
require_recipe "php"


# Some nice to haves
%w{ iftop curl unzip }.each do |a_package|
  package a_package
end

# mongo repo key
execute "mongo-10gen-key" do
  command "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10"
  action :run                                                                                                                                                
end

# mongo repo
# deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen
apt_repository "mongo10gen" do
  uri "http://downloads-distro.mongodb.org/repo/ubuntu-upstart"
  distribution "dist"
  components ["10gen"]
  action :add
end

# install mongo pkg
%w{ mongodb-10gen php5-mysql php5-gd php5-curl }.each do |a_package|
  package a_package
end


# PHP extras
php_pear "mongo" do
  action :install
end

php_pear "mongo" do
  action :install
end

# required by apc
%w{ libpcre3-dev }.each do |a_package|
  package a_package
end

# use 3.1.6, cause 3.1.7 is beta and dumps a bunch of crap in the logs.
php_pear "apc" do
  action :install
  version "3.1.6"
  directives(:shm_size => '64M', :enable_cli => 1)
end

execute "disable-default-site" do
  command "sudo a2dissite default"
  notifies :reload, resources(:service => "apache2"), :delayed
end
execute "enable-ssl" do
  command "sudo a2enmod ssl"
  notifies :reload, resources(:service => "apache2"), :delayed
end

web_app "shopify-dev" do
  template "shopify-dev.conf.erb"
  notifies :reload, resources(:service => "apache2"), :delayed
end
