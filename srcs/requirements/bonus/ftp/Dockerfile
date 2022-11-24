FROM debian:buster

ARG DEBIAN_FRONTEND=noninteractive

# Install vsftpd (secure ftp deamon)
RUN apt-get update
RUN apt-get install -y --no-install-recommends --no-install-suggests \
        dumb-init \
        vsftpd

# Create anon_root_dir and remove write right so vsftpd to prevent errors
RUN mkdir -p /etc/ftp
RUN chmod a-w /etc/ftp

COPY ./vsftpd.conf /etc/vsftpd.conf
RUN chown root /etc/vsftpd.conf

RUN mkdir -p /etc/ftp/wordpress
RUN chmod 777 /etc/ftp/wordpress
RUN chown ftp /etc/ftp/wordpress

EXPOSE 21
ENTRYPOINT ["/usr/bin/dumb-init", "--"]


CMD [ "/usr/sbin/vsftpd" ]

# ENTRYPOINT chmod 777 /etc/ftp/wordpress && chown ftp /etc/ftp/wordpress && service vsftpd start
# CMD /bin/sh