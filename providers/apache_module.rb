#
# Cookbook Name:: phpenv
# Provider:: phpenv_apache_module
#
# Copyright (C) 2013 Ga'bor Egyed
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
  Chef::Application.fatal!(
    "apache2 cookbook is missing. Please add it to the run_list."
   ) if ! run_context.loaded_recipe?("apache2")

  if "global" == new_resource.phpenv_version
    if current_global_version
      module_path = "#{node[:phpenv][:root_path]}/lib/libphp5.so"
    else
      Chef::Log.warn(
        "phpenv: global php version is not set, use phpenv_global to set it (action will be skipped)"
      )

      module_path = false
    end
  else
    module_path = "#{node[:phpenv][:root_path]}/versions/#{new_resource.phpenv_version}/libexec/libphp5.so"
  end

  if module_path && ::File.exists?(module_path)
    service "apache2" do
      action :nothing
    end

    template "#{node['apache']['dir']}/mods-available/php5.load" do
      source "apache/php5.load.erb"
      owner "root"
      group "root"
      mode 00644
      variables(
        :module_path => module_path,
      )
      notifies :restart, "service[apache2]"
    end

    template "#{node['apache']['dir']}/mods-available/php5.conf" do
      source "apache/php5.conf.erb"
      owner "root"
      group "root"
      mode 0644
      notifies :restart, "service[apache2]"
    end

    apache_module "php5"
  elsif module_path
    Chef::Log.warn(
      "apache module file doesn't exists \"#{module_path}\" (action will be skipped)"
    )
  end
end
