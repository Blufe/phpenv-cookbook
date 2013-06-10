#
# Cookbook Name:: phpenv
# Recipe:: install
#
# Copyright (C) 2013 Gábor Egyed
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
#

git node[:phpenv][:root_path] do
  repository node[:phpenv][:git_url]
  reference node[:phpenv][:git_ref]
  user node[:phpenv][:user]
  group node[:phpenv][:group]
  action :checkout
end

template "/etc/profile.d/phpenv.sh" do
  source "phpenv.sh.erb"
  owner "root"
  group "root"
  mode 00644
end

%w{ php-5.3.Linux.source php-5.4.Linux.source  php-5.5.Linux.source }.each do |file|
  cookbook_file "#{node[:phpenv][:root_path]}/etc/#{file}" do
    source file
    owner node[:phpenv][:user]
    group node[:phpenv][:group]
    mode 00644
  end
end

phpenv_script "phpenv-get-releases" do
  code "phpenv install --releases && touch #{node[:phpenv][:root_path]}/.last_updated" #  > /dev/null 2>&1
  user "root"
  group "root"
  action :run
  phpenv_root node[:phpenv][:root_path]
  not_if {
    File.exists?("#{node[:phpenv][:root_path]}/.last_updated") &&
    File.mtime("#{node[:phpenv][:root_path]}/.last_updated") > Time.now - 86400
  }
end
