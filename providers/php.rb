#
# Cookbook Name:: phpenv
# Provider:: phpenv_php
#
# Copyright (C) 2013 Gábor Egyed
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
#

use_inline_resources

def whyrun_supported?
  true
end

action :build do
  script_code = build_script_code

  if node[:phpenv][:chh][:default_configure_options].find {|option| option =~ /^--with-apxs2/}
    case node['platform_family']
    when 'rhel', 'fedora', 'arch'
      conf_path = "#{node['apache']['dir']}/conf/httpd.conf"
    when 'debian'
      conf_path = "#{node['apache']['dir']}/apache2.conf"
    when 'freebsd'
      conf_path = "#{node['apache']['dir']}/httpd.conf"
    end
    file conf_path do
      _file = Chef::Util::FileEdit.new(path)
      _file.insert_line_if_no_match(/^LoadModule .*$/, "LoadModule dummy dummy.so")
      _file.write_file
    end
  end

  install_start = Time.now

  phpenv_script "php-#{new_resource.name}" do
    phpenv_root node[:phpenv][:root_path]
    code script_code
    user node[:phpenv][:user]
    group node[:phpenv][:group]
    action :run
    environment new_resource.environment
    not_if { Dir.exists?("#{node[:phpenv][:root_path]}/versions/#{new_resource.release}") }
  end

  Chef::Log.debug("#{new_resource} build time was " +
    "#{(Time.now - install_start)/60.0} minutes")
end

private

def build_script_code
  script = []

  phpenv_type = node[:phpenv][:type]
  if phpenv_type == "chh"
    script << %{phpenv install #{new_resource.release}}
    if node[:phpenv][:chh][:default_configure_options].find {|option| option =~ /^--with-apxs2/}
      script << %{mv #{node['apache']['dir']}/modules/libphp5.so #{node[:phpenv][:root_path]}/versions/#{new_resource.release}/libexec/libphp5.so}
    end
  end

  script.join(" ")
end
