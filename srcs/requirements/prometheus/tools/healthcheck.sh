#!/bin/sh
set -e

if ! pgrep prometheus > /dev/null; then
    echo "Error: Prometheus is not running"
    exit 1
fi

if ! netstat -tuln | grep -q ":9090.*LISTEN"; then
    echo "Error: Prometheus is not listening on port 9090"
    exit 1
fi

if ! curl -s http://localhost:9090/-/healthy > /dev/null; then
    echo "Error: Prometheus health check failed"
    exit 1
fi

echo "Prometheus container is healthy"
exit 0
