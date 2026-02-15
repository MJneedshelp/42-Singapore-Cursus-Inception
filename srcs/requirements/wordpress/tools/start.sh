#!/bin/sh

# Read the secrets
DB_PASSWORD=$(cat /run/secrets/db_password)
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

# Wait for MariaDB to be up
echo "Maria are you up..."
until mysqladmin ping -h"$DB_HOST" --silent; do
	sleep 1
done

cd /var/www/html

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

# Install WordPress if not installed
if ! wp core is-installed --allow-root; then
	echo "Installing WordPress..."
	wp core install \
		--url="$DOMAIN_NAME" \
		--title="Inception Site" \
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
