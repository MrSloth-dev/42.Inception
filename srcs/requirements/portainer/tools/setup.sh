#!/bin/sh
set -e
if [ ! -w "/var/run/docker.sock" ]; then
    echo "Warning: Docker socket is not writable. Trying to fix permissions..."
    chmod 666 /var/run/docker.sock || echo "Failed to change permissions on Docker socket"
fi
echo "Starting Portainer..."
exec /usr/local/bin/portainer \
  --data /data \
