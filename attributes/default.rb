#
# Cookbook Name:: phpenv
# Attribute:: default
#
# Copyright (C) 2013 Gábor Egyed
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
#

default["phpenv"]["src"] = "/usr/local/src/phpenv"
default["phpenv"]["root_path"] = "/usr/local/phpenv"
default["phpenv"]["user"] = "root"
default["phpenv"]["group"] = "phpenv"

default["phpenv"]["type"] = "chh"
default["phpenv"]["chh"]["git_url"] = "https://github.com/CHH/phpenv.git"
default["phpenv"]["chh"]["git_ref"] = "master"
default["phpenv"]["chh"]["php-build"]["git_url"] = "https://github.com/CHH/php-build.git"
default["phpenv"]["chh"]["php-build"]["git_ref"] = "master"
default["phpenv"]["chh"]["rbenv-install-to-chh-phpenv"]["url"] = "https://raw.github.com/hnw/php-build/plugin-to-chh-phpenv/bin/rbenv-install"
default["phpenv"]["chh"]["packages"] = %w{
 automake
 libxml2-devel
 libcurl-devel
 libjpeg-turbo-devel
 libpng-devel
 giflib-devel
 gd-devel
 libmcrypt-devel
 sqlite-devel
 libtidy-devel
 libxslt-devel
 bison
 chrpath
 flex
 lemon
 re2c
 tzdata
}

default["phpenv"]["phps"] = []
default["phpenv"]["global"] = nil
default["phpenv"]["apache_module"] = nil
