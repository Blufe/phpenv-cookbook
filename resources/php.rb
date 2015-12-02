#
# Cookbook Name:: phpenv
# Resource:: phpenv_php
#
# Copyright (C) 2013 Gábor Egyed
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
#

actions :build
default_action :build

attribute :release,        :kind_of => String, :name_attribute => true
attribute :build,          :kind_of => String, :default => ""
attribute :ini,            :kind_of => String
attribute :environment,    :kind_of => Hash
attribute :definition,     :kind_of => Hash
