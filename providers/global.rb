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
  current_version    = current_global_version
  curr_major_version = current_version.to_s.to_i
  curr_module_name   = "libphp#{curr_major_version}.so"
  curr_module_link   = "#{node['apache']['libexecdir']}/#{curr_module_name}"

  phpenv_version     = new_resource.phpenv_version
  major_version      = phpenv_version.to_s.to_i
  module_name        = "libphp#{major_version}.so"
  module_link        = "#{node['apache']['libexecdir']}/#{module_name}"
  module_path        = "#{node[:phpenv][:root_path]}/versions/#{phpenv_version}/#{module_link}"

  phpenv_script "set-golbal-version-#{phpenv_version}" do
    code "phpenv global #{phpenv_version}"
    user node[:phpenv][:user]
    group node[:phpenv][:group]
    phpenv_root node[:phpenv][:root_path]
    environment new_resource.environment
    only_if { current_version != phpenv_version }
  end

  link module_link do
    to module_path
    owner node[:phpenv][:user]
    group node[:phpenv][:group]
    only_if { ::File.file?(module_path) && curr_module_link != module_link }
  end
end
