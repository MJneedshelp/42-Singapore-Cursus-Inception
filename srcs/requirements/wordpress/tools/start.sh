#!/bin/sh

# -e: Exit on error. -u: undefined variables as errors | useful for debugging
set -eu

# Read the secrets
DB_PASSWORD="$(tr -d '\r\n' < /run/secrets/db_password)"
WP_ADMIN_PASSWORD="$(tr -d '\r\n' < /run/secrets/wp_admin_password)"

cd /var/www/html

# Download wordpress core if missing
echo "Check if WordPress core is downloaded already"
if [ ! -f wp-load.php ]; then
	echo "WordPress core not found. Downloading WordPress core..."
	wp core download --allow-root
	echo "WordPress core downloaded"
else
	echo "WordPress core is already downloaded"
fi

# Wait for MariaDB to be up
until mysqladmin ping -h "$DB_HOST" \
	-h"$DB_HOST" \
	-u"$DB_USER" \
	-p"$DB_PASSWORD" \
	--silent; do
	echo "Maria are you up..."
	sleep 1
done

# Create wp-config.php if missing
if [ ! -f wp-config.php ]; then
	echo "Creating wp-config.php..."
	wp config create \
		--dbname="$DB_NAME" \
		--dbuser="$DB_USER" \
		--dbpass="$DB_PASSWORD" \
		--dbhost="$DB_HOST" \
		--allow-root
fi
echo "wp-config.php created"

# Install WordPress if not installed
if ! wp core is-installed --allow-root; then
	echo "Installing WordPress..."
	wp core install \
		--url="$DOMAIN_NAME" \
		--title="$WP_SITE_TITLE" \
		--admin_user="$WP_ADMIN_USER" \
		--admin_password="$WP_ADMIN_PASSWORD" \
		--admin_email="$WP_ADMIN_EMAIL" \
		--allow-root
fi

# Get php version -> apoend to php-fpm version
PHP_VERSION="$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;')"
PHP_FPM_BIN="php-fpm${PHP_VERSION}"

# Execute php-fpm -> becomes PID 1 of the container
exec $PHP_FPM_BIN -F
