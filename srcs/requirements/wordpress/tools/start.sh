#!/bin/sh

PHP_VERSION="$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;')"
PHP_FPM_BIN="php-fpm${PHP_VERSION}"

# mj to adjust later
exec $PHP_FPM_BIN -F
