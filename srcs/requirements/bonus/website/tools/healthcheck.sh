#!/bin/sh
set -e

if ! pgrep -f "nginx: master" > /dev/null; then
    echo "Error: nginx master process is not running"
    exit 1
fi

if ! netstat -tuln 2>/dev/null | grep -q ":9090.*LISTEN"; then
    echo "Error: nginx is not listening on port 9090"
    exit 1
fi

echo "Website container is healthy"
exit 0
