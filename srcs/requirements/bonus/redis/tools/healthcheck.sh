#!/bin/bash
set -e
DB_USER=$(cat /run/secrets/db_user 2>/dev/null)
DB_PASSWORD=$(cat /run/secrets/db_password 2>/dev/null)
DB_HOST=$(cat /run/secrets/wp_db_host 2>/dev/null)
WP_DIR="/var/www/html"

echo "Test php process"
if ! pgrep -x "php-fpm7.4" > /dev/null; then
    echo "Error: php-fpm is not running"
    exit 1
fi

echo "Test 9000 port"
if ! netstat -tulpn | grep -q ":9000.*LISTEN"; then
    echo "Error: php-fpm is not listening on port 9000"
    exit 1
fi

echo "Test mysql"
if ! mysqladmin ping -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" --silent; then
    echo "Error: Cannot connect to MySQL database"
    exit 1
fi

echo "WordPress container is healthy"
exit 0
