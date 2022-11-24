#!/bin/bash

# If database aready exists --> skip
if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then

# Start database
service mysql start

# Wait to make sure that db is up.
sleep 3

# MySQL commands to setup database and database user using heredoc
mysql -u root <<DATA
CREATE DATABASE $DB_NAME;
CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON wordpress.* TO '$DB_USER'@'%';
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$DB_PASS_ROOT');
DATA

# Stopping mysql before running the daemon
# service mysql stop
/etc/init.d/mysqld stop

# Wait to make sure mysql stopped.
sleep 3

echo "Database created."

else
echo "Database already exists."

fi

# Keep container running
mysqld_safe