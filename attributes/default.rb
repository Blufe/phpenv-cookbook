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
 make
 git
 autoconf
 autoconf2.13
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
 apache2-prefork-dev
 bison
 chrpath
 debhelper
 flex
 freetds-dev
 hardening-wrapper
 lemon
 libapr1-dev
 libbz2-dev
 libcurl4-openssl-dev
 libdb-dev
 libedit-dev
 libenchant-dev
 libevent-dev
 libexpat1-dev
 libfreetype6-dev
 libgcrypt11-dev
 libgd2-xpm-dev
 libglib2.0-dev
 libgmp3-dev
 libicu-dev
 libjpeg-dev
 libjpeg62-dev
 libkrb5-dev
 libldap2-dev
 libmagic-dev
 libmcrypt-dev
 libmhash-dev
 libmysqlclient-dev
 libpam0g-dev
 libpcre3-dev
 libpng12-dev
 libpq-dev
 libpspell-dev
 librecode-dev
 libsasl2-dev
 libsnmp-dev
 libsqlite3-dev
 libssl-dev
 libtidy-dev
 libtool
 libwrap0-dev
 libxml2-dev
 libxmltok1-dev
 libxslt1-dev
 netbase
 netcat
 netcat-openbsd
 re2c
 tzdata
 unixodbc-dev
 zlib1g-dev
}

default["phpenv"]["phps"] = []
default["phpenv"]["global"] = nil
default["phpenv"]["apache_module"] = nil
