#
# Cookbook Name:: phpenv
# Recipe:: install
#
# Copyright (C) 2013 Gábor Egyed
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
#

phpenv_type = node["phpenv"]["type"]

template "/etc/profile.d/phpenv.sh" do
  source "phpenv.sh.erb"
  owner "root"
  group "root"
  mode 00644
end

if phpenv_type == "chh"
  git node["phpenv"]["src"] do
    repository node["phpenv"][phpenv_type]["git_url"]
    reference node["phpenv"][phpenv_type]["git_ref"]
    user node["phpenv"]["user"]
    group node["phpenv"]["group"]
    action :sync
  end

  execute "install phpenv" do
    cwd "#{node['phpenv']['src']}/bin"
    command "./phpenv-install.sh"
    environment ({
      'PHPENV_ROOT' => node['phpenv']['root_path'],
      'PATH' => "#{node['phpenv']['root_path']}/bin:#{ENV['PATH']}"
    })
    not_if "which phpenv;", :environment => {
        'PHPENV_ROOT' => node['phpenv']['root_path'],
        'PATH' => "#{node['phpenv']['root_path']}/bin:#{ENV['PATH']}"
      }
  end

  %w{plugins shims versions}.each do |dir|
    directory "#{node['phpenv']['root_path']}/#{dir}" do
      owner node["phpenv"]["user"]
      group node["phpenv"]["group"]
      mode 00755
      action :create
    end
  end

  git "#{node['phpenv']['root_path']}/plugins/php-build" do
    repository node["phpenv"][phpenv_type]["php-build"]["git_url"]
    reference node["phpenv"][phpenv_type]["php-build"]["git_ref"]
    user node["phpenv"]["user"]
    group node["phpenv"]["group"]
    action :sync
  end
  remote_file "#{node['phpenv']['root_path']}/plugins/php-build/bin/rbenv-install" do
    source node["phpenv"][phpenv_type]["rbenv-install-to-chh-phpenv"]["url"]
    user node["phpenv"]["user"]
    group node["phpenv"]["group"]
    mode 00755
    action :create
  end
end

