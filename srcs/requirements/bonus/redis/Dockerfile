FROM debian:buster

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
	redis-server \
	php7.3-redis
RUN apt-get install dumb-init -y

ARG REDIS_PASSWORD
RUN sed -i "s/__REDIS_PASSWORD__/${REDIS_PASSWORD}/g" /etc/redis/redis.conf
RUN sed -i 's/bind 127.0.0.1 ::1/bind 0.0.0.0/g' /etc/redis/redis.conf

EXPOSE 6379

# RUN mkdir -p /var/vcap/sys/log/redis/
# RUN mkdir -p /var/vcap/store/redis

COPY ./redis.conf /etc/redis/redis.conf
COPY ./start.sh /usr/bin/start.sh
RUN chmod +x /usr/bin/start.sh

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD [ "start.sh", "redis-server", "/etc/redis/redis.conf" ]

# ENTRYPOINT ["start.sh"]
# CMD ["redis-server", "/etc/redis/redis.conf"]
