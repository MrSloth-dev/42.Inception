#!/bin/sh
set -e
cleanup () {
    unset REDIS_PASSWORD
}
trap cleanup EXIT

REDIS_PASSWORD=$(cat /run/secrets/redis_password)

cp /etc/redis.conf /etc/redis.custom.conf
echo "requirepass ${REDIS_PASSWORD}" >> /etc/redis.custom.conf 
echo $REDIS_PASSWORD

exec redis-server /etc/redis.custom.conf

