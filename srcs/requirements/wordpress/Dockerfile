FROM debian:buster

ARG DEBIAN_FRONTEND=noninteractive

# php 			 --> PHP is a programming language on which WordPress code is based
# php7.3-fpm	 --> This package provides the Fast Process Manager interpreter that runs as a daemon and receives Fast/CGI requests
# php-mysqli	 --> Connects to MySQL for database interactions
# mariadb-client --> MariaDB client is the tool which can be used for establishing the connection and interaction with the
#					 MariaDB server from the client-side by the user of the database
# curl			 --> Performs remote request operations
RUN apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y php7.3 \
	php7.3-fpm \
	php-mysqli \
	mariadb-client \
	curl && \
	apt-get update -y

# Create wordpress direcory -> wordpress CLI will be downloaded to this directive
RUN mkdir -p /var/www/wordpress
WORKDIR /var/www/wordpress

# Install wordpress CLI
# WP-CLI is the official command line tool for interacting with and managing your WordPress sites
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar

# Change exe name to wp
RUN mv wp-cli.phar /usr/local/bin/wp

# Php-fpm config
COPY ./www.conf /etc/php/7.3/fpm/pool.d

# Official wordpress config
COPY ./wp-config.php /var/www/wordpress

# Copy script that runs wordpress CLI installation
COPY ./php_wp_install.sh /
RUN chmod +x /php_wp_install.sh

# Expose port 9000 inside the docker network
EXPOSE 9000

# Run the php-wp-install-script
ENTRYPOINT [ "/php_wp_install.sh" ]