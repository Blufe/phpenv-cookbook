#
# Cookbook Name:: phpenv
# Provider:: phpenv_global
#
# Copyright (C) 2013 Gábor Egyed
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
#

include Chef::Phpenv::Helpers

use_inline_resources

def whyrun_supported?
  true
end

action :set do
  current_version = current_global_version

  phpenv_script "set-golbal-version-#{new_resource.phpenv_version}" do
    code "phpenv global #{new_resource.phpenv_version}"
    user node[:phpenv][:user]
    group node[:phpenv][:group]
    phpenv_root node[:phpenv][:root_path]
    environment new_resource.environment
    only_if { current_version != new_resource.phpenv_version }
  end

  module_path = "#{node[:phpenv][:root_path]}/versions/#{new_resource.phpenv_version}/usr/lib64/httpd/modules/libphp5.so"
  link "#{node['apache']['dir']}/modules/libphp5.so" do
    to module_path
    owner node[:phpenv][:user]
    group node[:phpenv][:group]
    only_if "test -f #{module_path}"
  end
end
