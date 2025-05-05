#!/bin/bash
set -e

if ! pgrep vsftpd > /dev/null; then
    echo "Error: vsftpd is not running"
    exit 1
fi

if ! netstat -tuln | grep -q ":21.*LISTEN"; then
    echo "Error: vsftpd is not listening on port 21"
    exit 1
fi

echo "FTP container is healthy"
exit 0
