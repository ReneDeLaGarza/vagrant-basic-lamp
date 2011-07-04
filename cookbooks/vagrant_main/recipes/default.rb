require_recipe "apt"
require_recipe "apache2"
require_recipe "mysql::server"
require_recipe "php::php5"
require_recipe "phpmyadmin"

%w{ nfs-common debconf curl }.each do |a_package|
   package a_package
end 

cookbook_file "/tmp/phpmyadmin.deb.conf" do
  source "phpmyadmin.deb.conf"
end
bash "debconf_for_phpmyadmin" do
  code "debconf-set-selections /tmp/phpmyadmin.deb.conf"
end

package "phpmyadmin"
node[:hosts][:localhost_aliases].each do |site|
  # Configure the development site
  web_app site do
    template "sites.conf.erb"
    server_name site
    server_aliases [site]
    docroot "/vagrant/public/#{site}/www"
  end
end
