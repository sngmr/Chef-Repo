# Install httpd
package "httpd" do
  version "2.2.15-28.el6.centos"
  action :install
end

# Install MySQL
package "mysql-server" do
  version "5.1.69-1.el6_4"
  action :install
end

# Install PHP
%w{php php-mbstring php-mysql}.each do |pkg|
  package pkg do
    version "5.3.3-23.el6_4"
    action :install
  end
end

# Edit MySQL (my.cnf)
cookbook_file "/etc/my.cnf" do
  source "my.cnf"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, 'service[mysqld]'
end

# Start Services
service "httpd" do
  action [:enable, :start]
  supports :status => true, :restart => true, :reload => true, :graceful => true
end
service "mysqld" do
  action [:enable, :start]
  supports :status => true, :restart => true
end

