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
  end

  script.join(" ")
end
