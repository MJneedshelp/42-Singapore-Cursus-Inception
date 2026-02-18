#!/bin/sh

# -e: Exit on error. -u: undefined variables as errors | useful for debugging
set -eu

# Read the secrets
DB_PASSWORD=$(cat /run/secrets/db_password)
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

echo "before init"
echo "Contents of /var/lib/mysql:"
ls -l /var/lib/mysql || true


# Initialise DB if it is not already initialised
if [ ! -d "/var/lib/mysql/mysql" ]; then
	echo "Initializing MariaDB..."

	mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql

	mysqld --skip-networking --user=mysql &
	pid="$!"

	until mysqladmin ping --silent; do
		sleep 1
	done

	echo "Configuring database..."

	# Replace placeholders in .sql script with the environment var
	sed -e "s/__DB_ROOT_PASSWORD__/${DB_ROOT_PASSWORD}/" \
		-e "s/__DB_NAME__/${DB_NAME}/g" \
		-e "s/__DB_USER__/${DB_USER}/g" \
		-e "s/__DB_PASSWORD__/${DB_PASSWORD}/g" \
		/init.sql > /tmp/init_runtime.sql

	mysql < /tmp/init_runtime.sql

	mysqladmin -u root -p"${DB_ROOT_PASSWORD}" shutdown
	wait "$pid"
fi

mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

echo "Starting MariaDB normally..."
exec mysqld --user=mysql
