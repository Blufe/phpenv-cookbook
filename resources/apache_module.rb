#
# Cookbook Name:: phpenv
# Resource:: phpenv_apache_module
#
# Copyright (C) 2013 Gábor Egyed
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
#

actions :set
default_action :set

attribute :phpenv_version, :kind_of => String, :name_attribute => true
