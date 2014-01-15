#
# Cookbook Name:: mariadb
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# MariaDBのレポジトリを追加
yum_repository 'mariadb' do
  description "MariaDB Repository"
  baseurl "http://yum.mariadb.org/10.0/centos6-amd64"
  gpgkey "https://yum.mariadb.org/RPM-GPG-KEY-MariaDB"
  action :create
end

# MariaDBのパッケージをインストール
%w{MariaDB-server MariaDB-client MariaDB-devel}.each do |pkg|
  package pkg do
    options "--enablerepo=mariadb"
    action :install
  end
end

service "mysql" do
  action [:enable, :start]
  supports restart: true, status: true
end

# rootパスワードを設定
bash "set mysql root password" do
  code "mysqladmin -u root password '#{node['mariadb']['root_password']}'"
  only_if "mysqladmin -u root version"
end

# ユーザー作成
node['mariadb']['users'].each do |user|
  grant    = user['grant'] || "ALL PRIVILEGES"
  database = user['database'] || "*"
  table    = user['table'] || "*"
  host     = user['host'] || "localhost"
  password = user['password'] || nil
  bash "create user #{user['name']}" do
    mysql_code = "mysql -u root -p'#{node['mariadb']['root_password']}'"
    mysql_code << " -e 'GRANT #{grant} ON #{database}.#{table}"
    mysql_code << " TO #{user['name']}@#{host}"
    mysql_code << " IDENTIFIED BY \\'#{password}\\'" if password
    not_if "mysqladmin -u '#{user['name']}' -p'#{user['password']}' -e'quit'"
  end
end

bash "flush privileges" do
  code "mysqladmin -u root -p'#{node['mariadb']['root_password']}' flush-privileges"
end
