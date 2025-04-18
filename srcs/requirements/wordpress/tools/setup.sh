#!/usr/bin/env bash
set -eo pipefail

cleanup () {
    unset DB_PASSWORD DB_USER DB_NAME DB_HOST WP_ADMIN_USER WP_ADMIN_PASSWORD WP_ADMIN_EMAIL WP_URL
}
trap cleanup EXIT


DB_PASSWORD=$(cat /run/secrets/db_password)
DB_USER=$(cat /run/secrets/db_user)
DB_NAME=${WP_DB_NAME:-wordpress}
DB_HOST=$(cat /run/secrets/wp_db_host)
WP_ADMIN_USER=$(cat /run/secrets/wp_admin_user)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_ADMIN_EMAIL=$(cat /run/secrets/wp_admin_email)
WP_URL=$(cat /run/secrets/wp_url)
DOMAIN_NAME=$(cat /run/secrets/domain_name)

echo "Checking Database"
until mysqladmin ping -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" --silent; do
    echo "Waiting for MySQL to start..."
    sleep 2
done
echo "Database is online"

if [ ! -f "/var/www/html/wp-config.php" ]; then
    echo "Wordpress config"
    wp config create --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASSWORD" --dbhost="$DB_HOST" --allow-root
    echo "Wordpress installing"
    wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_email="$WP_ADMIN_EMAIL" \
        --admin_password="$WP_ADMIN_PASSWORD" --allow-root
    echo "Wordpress installed successfully"
    chown -R www-data:www-data /var/www/html
else
    CURRENT_URL=$(wp option get siteurl --allow-root 2>/dev/null || echo "")
    if [ "$CURRENT_URL" != "$WP_URL" ]; then
        echo "Update home and siteurl and add theme"
        wp option update home "$WP_URL" --allow-root
        wp option update siteurl "$WP_URL" --allow-root
    fi
fi
echo "Exec php as PID 1"
exec php-fpm7.4 -F
