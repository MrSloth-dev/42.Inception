#!/bin/bash
set -e
if ! pgrep -x "nginx" > /dev/null; then
    echo "Error: nginx is not running"
    exit 1
fi

if ! netstat -tunl | grep -q "443.*LISTEN"; then
    echo "Port 443 in not set for listen"
    exit 1
fi

if ! nginx -t &>/dev/null; then
    echo "Error: nginx configuration is not valid"
    exit 1
fi

echo "NGINX container is healthy"
exit 0
