#!/bin/sh
set -e
echo "Starting Portainer..."
exec /usr/local/bin/portainer \
  --data /data \
  --bind=:9000 \
  --assets /opt/portainer/public
