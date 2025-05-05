#!/bin/sh
set -e


if ! pgrep php-fpm8 > /dev/null; then
    echo "Error: Php-fpm is not running"
    exit 1
fi
if ! netstat -tuln | grep -q ":9000.*LISTEN"; then
    echo "Error: Php-fpm is not listening on port 9000"
    exit 1
fi
echo "Adminer container is healthy"
exit 0

