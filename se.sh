#!/usr/bin/bash
mkdir -p secrets
USER=joao-pol
PASS=inutil42
DOMAIN_NAME=$USER.42.fr
echo "$DOMAIN_NAME" > ./secrets/domain_name
WP_URL=https://"$USER".42.fr
echo "$WP_URL" > ./secrets/wp_url
WP_HOME=https://"$USER".42.fr
echo "$WP_HOME" > ./secrets/wp_home
WP_DB_HOST=mariadb
echo "$WP_DB_HOST" > ./secrets/wp_db_host
WP_DB_NAME=wordpress
echo "$WP_DB_NAME" > ./secrets/wp_db_name
DB_USER="$USER"
echo "$DB_USER" > ./secrets/db_user
DB_ROOT_PASSWORD="$PASS"
echo "$DB_ROOT_PASSWORD" > ./secrets/db_root_password
WP_USER=joao-pol
echo "$WP_USER" > ./secrets/wp_user
WP_USER_PASSWORD="$PASS"
echo "$WP_USER_PASSWORD" > ./secrets/wp_user_password
WP_USER_EMAIL="joao8barbosa@gmail.com"
echo "$WP_USER_EMAIL" > ./secrets/wp_user_email
WP_ADMIN_USER=superuser
echo "$WP_ADMIN_USER" > ./secrets/wp_admin_user
WP_ADMIN_PASSWORD="$PASS"
echo "$WP_ADMIN_PASSWORD" > ./secrets/wp_admin_password
WP_ADMIN_EMAIL="$USER"@student.42porto.com
echo "$WP_ADMIN_EMAIL" > ./secrets/wp_admin_email
DB_PASSWORD="$PASS"
echo "$DB_PASSWORD" > ./secrets/db_password
DB_HOST=mariadb
echo "$DB_HOST" > ./secrets/db_host
REDIS_PASSWORD="$PASS"
echo "$REDIS_PASSWORD" > ./secrets/redis_password
FTP_USER="$USER"
echo "$FTP_USER" > ./secrets/ftp_user
FTP_PASSWORD="$PASS"
echo "$FTP_PASSWORD" > ./secrets/ftp_password
FTP_PASV_ADDRESS=127.0.0.1
echo "$FTP_PASV_ADDRESS" > ./secrets/ftp_pasv_address
PORT_PASSWORD="$PASS"
echo "$PORT_PASSWORD" > ./secrets/port_password

