<?php
define('DB_NAME', 'wordpress')
define('DB_USER', 'wpuser')
define('DB_PASSWORD', getenv('DB_PASSWORD'))
define('DB_HOST', 'mariadb')
define('DB_CHARSET', 'utf8mb4')
define('WP_HOME', 'https://' . getenv('DOMAIN_NAME'))
define('WP_SITEURL', 'https://' . getenv('DOMAIN_NAME'))
define('REDIS_PASSWORD', getenv('REDIS_PASSWORD'))
