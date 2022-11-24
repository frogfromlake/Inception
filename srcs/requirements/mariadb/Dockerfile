FROM debian:buster

ARG DEBIAN_FRONTEND=noninteractive

# MariaDB as underlying data storage for WordPress
RUN apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y mariadb-server

# Copy MariaDB install-script to root dir
COPY ./mariadb_install.sh /
RUN chmod +x /mariadb_install.sh

# Copy official MariaDB config
COPY ./50-server.cnf /etc/mysql/mariadb.conf.d/

# Expose port 3306 inside the docker network
EXPOSE 3306

# Run copied MariaDB install-script
ENTRYPOINT [ "/mariadb_install.sh" ]