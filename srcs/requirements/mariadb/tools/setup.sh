#!/bin/sh


service mysql start

sleep 5

mysql -u root -e "CREATE DATABASE IF NOT EXISTS wordpress;"
mysql -u root -e "CREATE USER 'wpuser'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mysql -u root -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%';"
mysql -u root -e "FLUSH PRIVILEGES;"
tail -f /dev/null
