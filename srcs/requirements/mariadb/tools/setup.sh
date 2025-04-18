#!/usr/bin/env bash
set -eo pipefail

cleanup () {
    unset DB_PASSWORD DB_USER DB_ROOT_PASSWORD
}

trap cleanup EXIT
DB_PASSWORD=$(cat /run/secrets/db_password)
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
DB_USER=$(cat /run/secrets/db_user)

echo "Initializing MySQL data directory...."
mysqld &
MYSQLPID=$!
chown -R mysql:mysql /var/lib/mysql

until mysqladmin --user=root -p$DB_ROOT_PASSWORD ping -h localhost --silent; do
    echo "Waiting for MySQL to start..."
    sleep 2
done

echo "Script into mysql"

mysql -u root --password=$DB_ROOT_PASSWORD<<EOF
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF

echo "Changing permissions of data dir"

find /var/lib/mysql -type d -exec chmod 750 {} \;
find /var/lib/mysql -type f -exec chmod 640 {} \;
echo "Shutdown with mysqladmin"
mysqladmin -u root -p$DB_ROOT_PASSWORD shutdown
wait $MYSQLPID

echo "Exec mysqld as PID 1"
exec mysqld
