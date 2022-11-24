#!/bin/bash

# The available folder is used to store all config files
# If a symbolic link is placed in the enabled folder the
# server becomes actually reachable

ln -s /etc/nginx/sites-available/fquist.42.fr /etc/nginx/sites-enabled/
ln -s /etc/nginx/sites-available/fquist.fr /etc/nginx/sites-enabled/


# Inside the .crt file a ssl certificate is stored, which is send to all clients
# Inside the .key file a private ssl key is stored

if [ ! -f /etc/ssl/certs/nginx.crt ]; then
echo "Nginx: setting up ssl ...";
openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
		-keyout /etc/ssl/private/nginx.key -out \
		/etc/ssl/certs/nginx.crt -sha256 -subj "/CN=fquist.42.fr";
echo "Nginx: ssl is set up!";
fi

nginx -g 'daemon off;'