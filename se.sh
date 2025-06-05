#!/usr/bin/bash
mkdir -p secrets
USER=$(whoami)
PASS=${1:-password}
DOMAIN_NAME=$USER.42.fr
WP_URL=https://"$USER".42.fr
WP_HOME=https://"$USER".42.fr
WP_DB_HOST=mariadb
WP_DB_NAME="$USER"
DB_USER="$USER"
DB_ROOT_PASSWORD="$PASS"
WP_USER=superuser
WP_USER_PASSWORD="$PASS"
WP_USER_EMAIL="joao8barbosa@gmail.com"
WP_ADMIN_USER=superuser
WP_ADMIN_PASSWORD="$PASS"
WP_ADMIN_EMAIL="$USER"@student.42porto.com
DB_PASSWORD="$PASS"
DB_HOST=mariadb
REDIS_PASSWORD="$PASS"
FTP_USER="$USER"
FTP_PASSWORD="$PASS"
FTP_PASV_ADDRESS=127.0.0.1
echo "$DOMAIN_NAME" > ./secrets/domain_name
echo "$WP_URL" > ./secrets/wp_url
echo "$WP_HOME" > ./secrets/wp_home
echo "$WP_DB_NAME" > ./secrets/wp_db_name
echo "$WP_ADMIN_EMAIL" > ./secrets/wp_admin_email
echo "$WP_DB_HOST" > ./secrets/wp_db_host
echo "$DB_USER" > ./secrets/db_user
echo "$WP_ADMIN_USER" > ./secrets/wp_admin_user
echo "$DB_ROOT_PASSWORD" > ./secrets/db_root_password
echo "$WP_ADMIN_PASSWORD" > ./secrets/wp_admin_password
echo "$DB_PASSWORD" > ./secrets/db_password
echo "$DB_HOST" > ./secrets/db_host
echo "$REDIS_PASSWORD" > ./secrets/redis_password
echo "$FTP_USER" > ./secrets/ftp_user
echo "$FTP_PASSWORD" > ./secrets/ftp_password
echo "$FTP_PASV_ADDRESS" > ./secrets/ftp_pasv_address

