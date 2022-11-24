#!/bin/bash

# Wait some second to make sure that the Database is running
sleep 3

wp core download --allow-root

# Install wp
if ! wp --allow-root core is-installed;
	then
	wp core install --url=$WP_URL \
		--title=$WP_TITLE \
		--admin_user=$WP_ADMIN_USER \
		--admin_password=$WP_ADMIN_PASSWORD \
		--admin_email=$WP_ADMIN_EMAIL \
		--skip-email \
		--allow-root
fi;

if ! wp --allow-root user get ${WP_USER};
	then
	echo "${WP_USER} not found, creating..."
	wp --allow-root user create \
			${WP_USER} \
			${WP_USER_EMAIL} \
			--user_pass=${WP_USER_PASSWORD} \
			--role=${WP_USER_ROLE}
fi;

# Bonus
# Install redis cache plugin
wp plugin install redis-cache  --allow-root
wp plugin activate redis-cache --allow-root
wp redis enable --allow-root

# To fix -> enable to create .pid file, because /run/php directory doesn't exist
mkdir -p /var/run/php

# Run php-fpm7.3 listening for CGI request and force to stay in foreground and ignore daemonize option fromm configuration file
php-fpm7.3 -F