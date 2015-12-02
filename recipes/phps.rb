#
# Cookbook Name:: phpenv
# Recipe:: phps
#
# Copyright (C) 2013 Gábor Egyed
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
#

Array(node[:phpenv][:phps]).each do |php|
  if php.is_a?(Hash)
    phpenv_php php[:release] do
      environment php[:environment] if php[:environment]
      definition  php[:definition]  if php[:definition]
    end
  else
    phpenv_php php
  end
end

if node[:phpenv][:global]
  phpenv_global node[:phpenv][:global]
end

if node[:phpenv][:apache_module]
  phpenv_apache_module node[:phpenv][:apache_module]
end
