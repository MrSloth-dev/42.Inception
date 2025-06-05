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
WP_USER=$(cat /run/secrets/wp_user)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)
WP_USER_EMAIL=$(cat /run/secrets/wp_user_email)
WP_USER_EMAIL2=example@email.com
WP_URL=$(cat /run/secrets/wp_url)
DOMAIN_NAME=$(cat /run/secrets/domain_name)
REDIS_PASSWORD=$(cat /run/secrets/redis_password)

echo "Checking Database"
echo "host$DB_HOST" 
echo "user$DB_USER" 
echo "pass$DB_PASSWORD" 
until mysqladmin ping -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" --silent; do
    echo "Waiting for MySQL to start..."
    sleep 5
done
echo "Database is online"

if [ ! -f "/var/www/html/wp-config.php" ]; then
    echo "wp-config not found, creating Wordpress config"
    wp config create --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASSWORD" --dbhost="$DB_HOST" --allow-root
echo "Wordpress installing"
    wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_email="$WP_ADMIN_EMAIL" \
        --admin_password="$WP_ADMIN_PASSWORD" --allow-root
    echo "Wordpress installed successfully"
    chown -R www-data:www-data /var/www/html
else
echo "Wordpress installing"
    wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_email="$WP_ADMIN_EMAIL" \
        --admin_password="$WP_ADMIN_PASSWORD" --allow-root
    echo "Wordpress installed successfully"
    chown -R www-data:www-data /var/www/html
    CURRENT_URL=$(wp option get siteurl --allow-root 2>/dev/null || echo "")
    if [ "$CURRENT_URL" != "$WP_URL" ]; then
        echo "Update home and siteurl and add theme"
        wp option update home "$WP_URL" --allow-root
        wp option update siteurl "$WP_URL" --allow-root
    fi
fi
if wp user get "$WP_USER" --allow-root >/dev/null 2>&1; then
    echo "User '$WP_USER' already exists, skipping creation"
else
    echo "Creating WordPress user '$WP_USER'"
    if ! wp user create "$WP_USER" "$WP_USER_EMAIL" \
        --role=author \
        --user_pass="$WP_USER_PASSWORD" \
        --allow-root ; then
        wp user create "$WP_USER" "$WP_USER_EMAIL2" \
            --role=author \
            --user_pass="$WP_USER_PASSWORD" \
            --allow-root
    fi
    echo "WordPress user '$WP_USER' created successfully"
fi
#Stuff related to redis
wp plugin install redis-cache --activate --allow-root
wp config set WP_REDIS_PASSWORD "$REDIS_PASSWORD" --allow-root
wp config set WP_REDIS_HOST redis --allow-root
wp config set WP_REDIS_PORT 6379 --allow-root
wp config set WP_REDIS_TIMEOUT 1 --allow-root
wp config set WP_REDIS_READ_TIMEOUT 1 --allow-root
wp config set WP_REDIS_DATABASE 0 --allow-root
wp redis enable --allow-root
wp redis update-dropin --allow-root
wp redis status --allow-root || echo "Error: Redis connection failed";
echo "Exec php as PID 1"
exec php-fpm7.4 -F
