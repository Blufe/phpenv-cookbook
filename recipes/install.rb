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
    not_if { File.exists?("#{node['phpenv']['root_path']}/bin/phpenv") }
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
  template "#{node['phpenv']['root_path']}/plugins/php-build/share/php-build/default_configure_options" do
    source "default_configure_options.erb"
    owner node["phpenv"]["user"]
    group node["phpenv"]["group"]
    mode 00755
    variables({
      "default_configure_options" => node['phpenv'][phpenv_type]['default_configure_options']
    })
  end
  unless node['phpenv'][phpenv_type]['add_extensions'].blank?
    node['phpenv'][phpenv_type]['add_extensions'].each do |ext_name, ext|
      ext_data =  %Q{"#{ext_name}"}
      ext_data << ","
      ext_data << %Q{"#{ext["url_dist"]}"}
      ext_data << ","
      ext_data << %Q{"#{ext["url_source"]}"}
      ext_data << ","
      ext_data << %Q{"#{ext["source_cwd"]}"}     unless ext["source_cwd"].blank?
      ext_data << ","
      ext_data << %Q{"#{ext["configure_args"]}"} unless ext["configure_args"].blank?
      ext_data << ","
      ext_data << (ext["extension_type"].blank? ? %Q{"extension"} : %Q{"#{ext["extension_type"]}"})
      ext_data << ","
      ext_data << %Q{"#{ext["after_install"]}"}  unless ext["after_install"].blank?
      file "#{node['phpenv']['root_path']}/plugins/php-build/share/php-build/extension/definition" do
        _file = Chef::Util::FileEdit.new(path)
        _file.insert_line_if_no_match(/^"#{ext_name}".*$/, ext_data)
        _file.write_file
      end
    end
  end
end
