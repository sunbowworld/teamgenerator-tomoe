#
# Cookbook Name:: base
# Recipe:: package
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Rubyに必要なパッケージのインストール
(%w{gcc-c++ patch readline readline-devel zlib zlib-devel} +
%w{libffi-devel openssl-devel make bzip2 autoconf automake} +
%w{libtool bison libyaml-devel}).each do |pkg|
  yum_package pkg do
    action :install
    options "--enablerepo=epel"
  end
end

# Passengerに必要なパッケージのインストール
(%w{libxml2-devel libxslt-devel curl-devel httpd-devel} +
%w{apr-devel apr-util-devel}).each do |pkg|
  yum_package pkg do
    action :install
  end
end
