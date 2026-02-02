# Start from Debian base (mj to check the version later)
FROM debian:trixie

# Install php and php-fpm. apt clean to clear all the cached installation files
RUN apt update && apt install -y php php-fpm && apt clean

# Copy start up script
COPY tools/start.sh /start.sh

# Make setup script executable
RUN chmod +x /start.sh

# Expose only port 9000 for communicating with the NGINX container
EXPOSE 9000

# mj to fill in later
CMD ["/start.sh"]
