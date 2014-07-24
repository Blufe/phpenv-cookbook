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
  script_environment  = build_script_environment

  phpenv_type = node[:phpenv][:type]
  case phpenv_type
  when 'chh'
    options = node[:phpenv][:chh][:default_configure_options]
    if options.find {|option| option =~ /^--with-apxs2/}
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
        _file.insert_line_if_no_match(/^LoadModule .*$/, "#LoadModule dummy dummy.so")
        _file.write_file
      end

#      script << %{mv #{node['apache']['dir']}/modules/libphp5.so #{node[:phpenv][:root_path]}/versions/#{new_resource.release}/libexec/libphp5.so;}
    end
  end

  install_start = Time.now

  phpenv_script "php-#{new_resource.name}" do
    phpenv_root node[:phpenv][:root_path]
    code script_code
    user node[:phpenv][:user]
    group node[:phpenv][:group]
    action :run
    environment(script_environment)
    not_if { Dir.exists?("#{node[:phpenv][:root_path]}/versions/#{new_resource.release}") }
  end

  Chef::Log.debug("#{new_resource} build time was " +
    "#{(Time.now - install_start)/60.0} minutes")

end

private

def build_script_code
  script = []

  phpenv_type = node[:phpenv][:type]
  case phpenv_type
  when 'chh'
    script << %{phpenv install #{new_resource.release};}
  end

  script.join(" ")
end

def build_script_environment
  script_env = {
    'PKG_CONFIG_PATH' => node[:phpenv][:pkgconfig_path],
    'PHP_BUILD_CONFIGURE_OPTS' => "--libexecdir=#{node[:phpenv][:root_path]}/versions/#{new_resource.release}/libexec"
  }
  if new_resource.environment
    script_env.merge!(new_resource.environment)
  end

  script_env
end
