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
node[:phpenv][:packages].each do |pkg|
  package pkg
end

# insaltt the latest git (git >1.7.9 is requred by gitlab)
apt_repository "git" do
  uri "http://ppa.launchpad.net/git-core/ppa/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "E1DF1F24"
end

package "git" do
  action :upgrade
end
