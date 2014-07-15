#
# Cookbook Name:: phpenv
# Recipe:: base
#
# Copyright (C) 2013 Gábor Egyed
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
#

# install required packages
phpenv_type = node["phpenv"]["type"]
node["phpenv"][phpenv_type]["packages"].each do |pkg|
  package "phpenv-#{pkg}" do
    package_name pkg
    action :install
  end
end

