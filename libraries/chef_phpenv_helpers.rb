#
# Cookbook Name:: phpenv
# Library:: Chef::Phpenv::Helpers
#
# Copyright (C) 2013 Gábor Egyed
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.

class Chef
  module Phpenv
    module Helpers

      def current_global_version
        version_file = ::File.join(node[:phpenv][:root_path], 'version')

        ::File.exists?(version_file) && ::IO.read(version_file).chomp
      end

    end
  end
end

