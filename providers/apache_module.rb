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
  curr_major_version = current_apache_module_version
  major_version      = new_resource.phpenv_version.to_i.to_s

  Chef::Application.fatal!(
    "apache2 cookbook is missing. Please add it to the run_list."
   ) if ! run_context.loaded_recipe?("apache2")

  recipe = self
  ruby_block "phpenv#set-php-mod" do
    block do
      if "global" == new_resource.phpenv_version
        if current_global_version
          module_path = "#{node['apache']['libexecdir']}/libphp#{curr_major_version}.so"
        else
          Chef::Log.warn(
            "phpenv: global php version is not set, use phpenv_global to set it (action will be skipped)"
          )

          module_path = false
        end
      else
        module_path = "#{node['apache']['libexecdir']}/libphp#{major_version}.so"
      end

      if module_path && ::File.exists?(module_path)
        recipe.service "apache2" do
          service_name value_for_platform(
            ['centos','redhat','fedora','amazon'] => {'default' => 'httpd'},
            'default' => 'apache2'
          )
          action :nothing
        end

        recipe.apache_module "php#{curr_major_version}" do
          enable false
          only_if { curr_major_version != major_version }
        end

        recipe.apache_module "php#{major_version}" do
          module_path module_path
          conf true
        end
      elsif module_path
        Chef::Log.warn(
          "apache module file doesn't exists \"#{module_path}\" (action will be skipped)"
        )
      end
    end
  end
end
