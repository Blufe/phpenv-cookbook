#
# Cookbook Name:: phpenv
# Resource:: phpenv_script
#
# Copyright (C) 2013 Gábor Egyed
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
#

actions :run
default_action :use

attribute :name,           :kind_of => String, :name_attribute => true
attribute :code,           :kind_of => String
attribute :creates,        :kind_of => String
attribute :cwd,            :kind_of => String
attribute :environment,    :kind_of => Hash
attribute :group,          :kind_of => String
attribute :path,           :kind_of => Array
attribute :phpenv_root,    :kind_of => String, :required => true
attribute :phpenv_version, :kind_of => String
attribute :returns,        :kind_of => Array, :default => [ 0 ]
attribute :timeout,        :kind_of => Integer
attribute :user,           :kind_of => String
attribute :umask,          :kind_of => String
