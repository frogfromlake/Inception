FROM debian:buster

COPY ./start.sh /etc/start.sh
RUN chmod +x /etc/start.sh && chown root /etc/start.sh

ENTRYPOINT ./etc/start.sh
