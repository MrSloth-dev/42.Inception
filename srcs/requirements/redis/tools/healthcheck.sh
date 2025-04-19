#!/bin/sh
set -e

cleanup () {
    unset REDIS_PASSWORD
}
trap cleanup EXIT

REDIS_PASSWORD=$(cat /run/secrets/redis_password)

if ! pgrep redis-server > /dev/null; then
    echo "Error: Redis server is not running"
    exit 1;
fi
if ! redis-cli -a "$REDIS_PASSWORD" ping | grep -q "PONG"; then
    echo "Error: Redis server is not responding correctly"
    exit 1;
fi
echo "Redis container is healthy"
exit 0
