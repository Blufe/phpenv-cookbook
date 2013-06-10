#
# Cookbook Name:: phpenv
# Provider:: phpenv_global
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
end

private

def current_global_version
  version_file = ::File.join(node[:phpenv][:root_path], 'version')

  ::File.exists?(version_file) && ::IO.read(version_file).chomp
end
