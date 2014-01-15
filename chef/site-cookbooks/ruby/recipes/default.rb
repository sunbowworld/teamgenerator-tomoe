#
# Cookbook Name:: ruby
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

rbenv_root = "/usr/local/rbenv"

# 必要なパッケージのインストール
(
%w{gcc-c++ patch readline readline-devel zlib zlib-devel} +
%w{libffi-devel openssl-devel make bzip2 autoconf automake} +
%w{libtool bison libyaml-devel}
).each do |pkg|
  package pkg do
    options "--enablerepo=epel"
    action :install
  end
end

# rbenvをgithubからclone
git rbenv_root do
  repository "git://github.com/sstephenson/rbenv.git"
  reference "master"
  action :sync
end

# cloneでは作成されないディレクトリの作成
%w{shims versions plugins}.each do |sub_dir|
  directory "#{rbenv_root}/#{sub_dir}"
end

# ruby-buildをgithubからclone
git "#{rbenv_root}/plugins/ruby-build" do
  repository "git://github.com/sstephenson/ruby-build.git"
  reference "master"
  action :sync
end

# rbenv設定用scriptの設置
template "/etc/profile.d/rbenv.sh" do
  source "rbenv.sh.erb"
  owner "root"
  group "root"
  mode 00755
end

# 環境変数の設定
ruby_block "set RBENV_ROOT=#{rbenv_root}" do
  block do
    ENV['RBENV_ROOT'] = rbenv_root
  end
end

ruby_block "set PATH=#{rbenv_root}/shims:$PATH" do
  block do
    ENV['PATH'] = "#{rbenv_root}/shims:#{ENV['PATH']}"
  end
end

# rbenv.shの反映
#bash "source rbenv.sh" do
#  code "source /etc/profile.d/rbenv.sh"
#end

# Ruby install
bash "ruby install" do
  code "#{rbenv_root}/bin/rbenv install #{node['ruby']['version']}"
  creates "#{rbenv_root}/versions/#{node['ruby']['version']}/bin/ruby"
end

bash "ruby global" do
#  environment ({
#    "RBENV_ROOT" => rbenv_root,
#    "PATH" => ENV['PATH']
#  })
  code "#{rbenv_root}/bin/rbenv global #{node['ruby']['version']}"
end

# rbenv rehash
bash "rbenv rehash" do
  code "#{rbenv_root}/bin/rbenv rehash"
end

# gem system update
bash "gem system update" do
  code "#{rbenv_root}/shims/gem update --system"
end

gem_package "bundler" do
  version node['ruby']['bundler']['version']
  gem_binary "#{rbenv_root}/versions/#{node['ruby']['version']}/bin/gem"
  notifies :run, "bash[rbenv rehash]", :immediately
end

