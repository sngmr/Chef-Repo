# Download and Uncompress SeeZoo
bash 'download and uncompress seezoo' do
  code <<-EOH1
  cd /tmp
  curl -L -O https://bitbucket.org/seezoo/seezoo/get/cba1c7d65244.zip
  chmod 777 cba1c7d65244.zip
  su vagrant -c "unzip /tmp/cba1c7d65244.zip"
  su vagrant -c "mkdir -p /var/www/html/seezoo"
  mv seezoo-seezoo-cba1c7d65244/src/* /var/www/html/seezoo
  mv /var/www/html/seezoo/system/application/config_sample /var/www/html/seezoo/system/application/config
  rm -f cba1c7d65244.zip
  rm -fr seezoo-seezoo-cba1c7d65244
  EOH1
  not_if {
    File.exists?("/var/www/html/seezoo")
  }
end

# Create Database
bash 'setup_database' do
  code <<-EOH2
    mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS seezoo DEFAULT CHARACTER SET utf8;
EOF
  EOH2
end
