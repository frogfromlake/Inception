# Base img
FROM debian:buster

#install nginx
COPY ./index.html /var/www/static/index.html

RUN chown -R 755 /var/www/static/*

EXPOSE 4000
