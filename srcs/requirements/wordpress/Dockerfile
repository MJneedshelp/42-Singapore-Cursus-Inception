# Start from Debian base (mj to check the version later)
FROM debian:trixie

# Install system dependencies. apt clean to clear all the cached installation
# Shell form used instead of exec form cos of && for variable expansion. Reduce layers
RUN apt update && apt install -y \
	php php-fpm php-mysql \
	curl \
	mariadb-client \
	&& apt clean && rm -rf /var/lib/apt/lists/*

# Configure php-fpm to listen on port 9000 instead of the default socket file
RUN sed -i 's|^listen = .*|listen = 9000|' /etc/php/*/fpm/pool.d/www.conf

# Create directory to store the WordPress files
RUN mkdir -p /var/www/html

WORKDIR /var/www/html

# RUN curl -O https://wordpress.org/latest.tar.gz \
# 	&& tar -xzf latest.tar.gz --strip-components=1 \
# 	&& rm latest.tar.gz

# Download and install the wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

# Copy start up script
COPY tools/start.sh /start.sh

# Make setup script executable
RUN chmod +x /start.sh

# Expose only port 9000 for communicating with the NGINX container
EXPOSE 9000

# mj to fill in later
CMD ["/start.sh"]






#mj to check if there's a need to login to wordpress client
