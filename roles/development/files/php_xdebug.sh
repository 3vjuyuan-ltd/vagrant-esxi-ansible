#!/bin/bash

cd /root/php-src/xdebug-2.5.0/

/opt/php/bin/phpize

./configure --with-php-config=/opt/php/bin/php-config

make

make install