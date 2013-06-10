#
# Cookbook Name:: phpenv
# Attribute:: default
#
# Copyright (C) 2013 Gábor Egyed
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
#

default[:phpenv][:root_path] = "/opt/phpenv"
default[:phpenv][:user] = "root"
default[:phpenv][:group] = default[:phpenv][:user]
default[:phpenv][:git_url] = "https://github.com/phpenv/phpenv.git"
default[:phpenv][:git_ref] = "dev"
default[:phpenv][:packages] = %w{
  apache2-prefork-dev autoconf autoconf2.13 automake bison chrpath debhelper flex
  freetds-dev hardening-wrapper lemon libapr1-dev libbz2-dev libcurl4-openssl-dev
  libdb-dev libedit-dev libenchant-dev libevent-dev libexpat1-dev libfreetype6-dev
  libgcrypt11-dev libgd2-xpm-dev libglib2.0-dev libgmp3-dev libicu-dev libjpeg-dev
  libjpeg62-dev libkrb5-dev libldap2-dev libmagic-dev libmcrypt-dev libmhash-dev
  libmysqlclient-dev libpam0g-dev libpcre3-dev libpng12-dev libpq-dev libpspell-dev
  librecode-dev libsasl2-dev libsnmp-dev libsqlite3-dev libssl-dev libtidy-dev
  libtool libwrap0-dev libxml2-dev libxmltok1-dev libxslt1-dev netbase netcat
  netcat-openbsd re2c tzdata unixodbc-dev zlib1g-dev
}
