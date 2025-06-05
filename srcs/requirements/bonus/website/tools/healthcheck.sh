#!/bin/bash
set -e
if ! pgrep -x "nginx" > /dev/null; then
    echo "Error: nginx is not running"
    exit 1
fi

if ! netstat -tunl | grep -q "8080.*LISTEN"; then
    echo "Port 8080 in not set for listen"
    exit 1
fi

if ! nginx -t &>/dev/null; then
    echo "Error: nginx configuration is not valid"
    exit 1
fi
if ! curl -vL http://localhost:8080/; then
    echo "Error: Website not accessible"


echo "NGINX container is healthy"
exit 0
