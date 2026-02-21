# Start from Debian base (mj to check the version later)
FROM debian:trixie

# Install system dependencies. apt clean to clear all the cached installation
# Shell form used instead of exec form cos of && for variable expansion. Reduce layers
RUN apt update && apt install -y \
	mariadb-server mariadb-client \
	&& apt clean && rm -rf /var/lib/apt/lists/*


# Update the server config so that MariaDB accepts connections from other containers
RUN sed -i 's/^[[:space:]]*bind-address.*/bind-address = 0.0.0.0/' \
	/etc/mysql/mariadb.conf.d/50-server.cnf

# Clear the
RUN rm -rf /var/lib/mysql/*

# Copy start up scripts
COPY tools/init.sh /init.sh
COPY tools/init.sql /init.sql

# Make start up script executable
RUN chmod +x /init.sh

# Expose only port 3306 for communicating with the WordPress container
EXPOSE 3306

# mj to fill in later
CMD ["/init.sh"]
