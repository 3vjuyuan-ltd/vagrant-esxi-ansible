#!/bin/bash

cd /root/php-src/php-7.1.1/

./buildconf --force

./configure --prefix=/opt/php --with-config-file-path=/opt/php/conf --enable-fpm --enable-mbstring --enable-zip --enable-bcmath --enable-pcntl --enable-ftp --enable-exif --enable-calendar --enable-sysvmsg --enable-sysvsem --enable-sysvshm --enable-wddx --with-curl=/usr/bin --with-mcrypt --with-iconv-dir=/usr --with-pspell --with-gd --with-jpeg-dir=/usr --with-png-dir=/usr --with-zlib-dir=/usr --with-xpm-dir=/usr --with-freetype-dir=/usr --enable-gd-native-ttf --enable-gd-jis-conv --with-openssl --enable-mysqlnd --with-pdo-mysql=mysqlnd --with-mysqli=mysqlnd --with-gettext=/usr --with-zlib=/usr --with-bz2=/usr --with-recode=/usr --with-tidy=/usr --with-xsl=/usr --with-ldap --with-xmlrpc --with-snmp=/usr --with-pear --with-libdir=/lib/x86_64-linux-gnu --enable-shmop --enable-maintainer-zts -enable-opcache --enable-sockets --with-snmp --enable-soap --enable-intl

make

make install

mkdir /opt/php/conf

#cp php.ini-development /opt/php/conf/php.ini

mv /opt/php/etc/php-fpm.conf.default /opt/php/etc/php-fpm.conf

mv /opt/php/etc/php-fpm.d/www.conf.default /opt/php/etc/php-fpm.d/www.conf

#修改用户和组
sed -i "s/user = nobody/user = www-data/g" /opt/php/etc/php-fpm.d/www.conf
sed -i "s/group = nobody/group = www-data/g" /opt/php/etc/php-fpm.d/www.conf

cp sapi/fpm/php-fpm /opt/php/bin/

#启动php-fpm
/opt/php/bin/php-fpm
