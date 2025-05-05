#!/bin/sh
set -e

if ! pgrep portainer > /dev/null; then
    echo "Error: Portainer is not running"
    exit 1
fi

if ! netstat -tuln | grep -q ":9000.*LISTEN"; then
    echo "Error: Portainer is not listening on port 9000"
    exit 1
fi

echo "Portainer container is healthy"
exit 0
