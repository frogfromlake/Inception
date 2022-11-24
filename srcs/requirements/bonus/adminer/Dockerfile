FROM debian:buster

ADD http://www.adminer.org/latest.php /var/www/adminer.php

RUN apt-get update -y && apt-get upgrade -y && apt-get install procps -y && chown -R www-data:www-data /var/www/adminer.php \
	&& chmod 755 /var/www/adminer.php
RUN apt-get install dumb-init -y

RUN mkdir -p /var/www/wordpress


COPY ./start.sh /usr/bin/start.sh
RUN chmod +x /usr/bin/start.sh

RUN cp /var/www/adminer.php /var/www/wordpress/adminer.php

EXPOSE 8080

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD [ "start.sh" ]