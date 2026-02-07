#!/bin/sh

# mj -> check if you want to store the cert path somewhere

# Create directory to store the SSL cert
mkdir -p /etc/nginx/ssl

# Generate a self-signed TLS cert
#	-x509: generate a certificate without a signing authority
#	-nodes: no DES to not encrypt the private key with a password
#	-days: cert validity
#	-newkey rsa:2048: generates a newkey with RSA algo with 2048-bit key length
#	-keyout: outputs the generated key; used by NGINX to decrypt the traffic
#	-out: location to save the cert
#	-subj: cert subject metadata, Country, State, Locality, Org, Common Name

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/key.pem \
-out /etc/nginx/ssl/cert.pem -subj "/C=SG/ST=TJPG/L=MyRoom/O=42/CN=${DOMAIN_NAME}"

# Print cert generated
echo "Self-signed cert created at /etc/nginx/ssl"

# Launch nginx in foreground (PID 1)
# -g: global directive to keep nginx running in foreground so that it becomes PID 1 in the container
# daemon off: disables daemon mode
exec nginx -g 'daemon off;'
