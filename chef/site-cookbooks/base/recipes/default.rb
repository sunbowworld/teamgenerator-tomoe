#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# 必要パッケージのインストール
%w{}.each do |pkg|
  action :install
end
