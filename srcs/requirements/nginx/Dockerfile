# Start from Debian base (mj to check the version later)
FROM debian:trixie

# Install NGINX and OpenSSL. apt clean to clear all the cached installation files
# Shell form used instead of exec form cos of && for variable expansion. Reduce layers
RUN apt update && apt install -y nginx openssl && apt clean

# Copy configuration files
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Copy setup script for SSL and nginx launch
COPY tools/setup.sh /setup.sh

# Make setup script executable
RUN chmod +x /setup.sh

# Expose only port 443 for HTTPS
EXPOSE 443

# Run setup and nginx as PID 1
CMD ["/setup.sh"]
