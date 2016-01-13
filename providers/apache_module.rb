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
    module_path = "#{node[:phpenv][:root_path]}/versions/#{new_resource.phpenv_version}/usr/lib64/httpd/modules/libphp5.so"
  end

  if module_path && ::File.exists?(module_path)
    service "apache2" do
      service_name value_for_platform(
        ['centos','redhat','fedora','amazon'] => {'default' => 'httpd'},
        'default' => 'apache2'
      )
      action :nothing
    end

    apache_module "php5" do
      module_path module_path
      conf true
    end
  elsif module_path
    Chef::Log.warn(
      "apache module file doesn't exists \"#{module_path}\" (action will be skipped)"
    )
  end
end
