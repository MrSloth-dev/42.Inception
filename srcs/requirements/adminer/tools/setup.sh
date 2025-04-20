#!/bin/sh
set -e
mkdir -p /run/nginx

php-fpm8 &
exec nginx -g "daemon off;"
