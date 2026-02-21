#!/bin/sh

# -e: Exit on error. -u: undefined variables as errors | useful for debugging
set -eu

# Read the secrets

read -r DB_PASSWORD < /run/secrets/db_password
read -r DB_ROOT_PASSWORD < /run/secrets/db_root_password

echo "DEBUG DB_ROOT_PASSWORD (visible form):"
printf '%s' "$DB_ROOT_PASSWORD" | cat -A


# Make the mysqld directory
echo "Making the directory: /run/mysqld"
mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

# Initialise DB if it is not already initialised
if [ ! -d "/var/lib/mysql/mysql" ]; then
	echo "Initializing MariaDB..."

	mariadb-install-db --user=mysql --datadir=/var/lib/mysql

	# # Update the server config so that MariaDB accepts connections
	# # from other containers
	# if [ -f /etc/mysql/mariadb.conf.d/50-server.cnf ]; then
	# 	sed -i 's/^[[:space:]]*bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf || true
	# fi

	echo "Starting temporary MariaDB server to create root users first"
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

	# Wait for process to end
	wait "$pid"
fi

echo "Starting MariaDB normally..."
exec mysqld --user=mysql
