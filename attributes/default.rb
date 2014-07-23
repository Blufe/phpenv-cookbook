#
# Cookbook Name:: phpenv
# Attribute:: default
#
# Copyright (C) 2013 Gábor Egyed
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
#

include_attribute 'apache2'

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
 libevent
 libevent-devel
 libtool-ltdl
 libtool-ltdl-devel
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
 httpd
 httpd-devel
 apr
 apr-devel
 apr-util-devel
 bison
 chrpath
 flex
 lemon
 re2c
 tzdata
}
default["phpenv"]["chh"]["default_configure_options"] = [
 '--without-pear',
 '--with-gd',
 '--enable-sockets',
 '--with-jpeg-dir=/usr',
 '--with-png-dir=/usr',
 '--enable-exif',
 '--enable-zip',
 '--with-zlib',
 '--with-zlib-dir=/usr',
 '--with-kerberos',
 '--with-openssl',
 '--with-mcrypt=/usr',
 '--enable-soap',
 '--enable-xmlreader',
 '--with-xsl',
 '--enable-ftp',
 '--enable-cgi',
 '--with-curl=/usr',
 '--with-tidy',
 '--with-xmlrpc',
 '--enable-sysvsem',
 '--enable-sysvshm',
 '--enable-shmop',
 '--with-mysql=mysqlnd',
 '--with-mysqli=mysqlnd',
 '--with-pdo-mysql=mysqlnd',
 '--with-pdo-sqlite',
 '--enable-pcntl',
 '--with-readline',
 '--enable-mbstring',
 '--disable-debug',
 '--enable-bcmath',
 '--disable-fpm',
 '--with-apxs2'
]

default["phpenv"]["phps"] = []
default["phpenv"]["global"] = nil
default["phpenv"]["apache_module"] = nil
