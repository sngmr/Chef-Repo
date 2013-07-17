# STOP FIREWALL
service "iptables" do
  action [:stop, :disable]
end
service "ip6tables" do
  action [:stop, :disable]
end

# yum update and clean
execute "clean-yum-cache" do
  command "yum clean all"
end
execute "yum-update" do
  command "yum update -y"
end
