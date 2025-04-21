#!/bin/sh
set -e
cleanup () {
    unset REDIS_PASSWORD
}
trap cleanup EXIT

if [ -f /run/secrets/ftp_user ] && [ -f /run/secrets/ftp_password ]; then
    FTP_USER=$(cat /run/secrets/ftp_user)
    FTP_PASSWORD=$(cat /run/secrets/ftp_password)
else
    FTP_USER=${FTP_USER:-ftp_user}
    FTP_PASSWORD=${FTP_PASSWORD:-ftp_password}
fi

if ! id "$FTP_USER" &>/dev/null; then
    adduser -D -h /var/www/html "$FTP_USER"
fi
echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

echo $FTP_USER >> /etc/csftpd.userlist

chown -R $FTP_USER:$FTP_USER /var/www/html
echo "THIS LINE RIGHT HERE"
ip route get 1
if [ -z "$PASV_ADDRESS" ]; then
  PASV_ADDRESS=$(ip route get 1 | awk '{print $(NF);exit}')
  echo "Auto-detected IP: $PASV_ADDRESS"
fi
echo "pasv_address=$PASV_ADDRESS" >> /etc/vsftpd/vsftpd.conf
echo "FTP server is starting..."
exec vsftpd /etc/vsftpd/vsftpd.conf

