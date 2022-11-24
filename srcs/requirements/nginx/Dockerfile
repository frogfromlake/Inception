FROM debian:buster

ARG DEBIAN_FRONTEND=noninteractive

# nginx --> The webserver is a piece of software that accepts user web requests and provides the appropriate result.
# openssl --> Is a library that contains SSL and TLS and permits SSL-based connections to other hosts.
# installing nginx and openssl
RUN apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y nginx \
	openssl \
	&& rm -rf /var/lib/apt/lists/*

# create self-signed ssl certificates for TLS
# req	  -->	the req command primarily creates and processes certificate requests
# -x509	  -->	this option outputs a self signed certificate instead of a certificate request
# -days n -->	when the -x509 option is being used this specifies the number of days to certify the certificate for.
# -nodes  -->	if this option is specified then if a private key is created it will not be encrypted.
#				Theoretically you could leave out the -nodes parameter (which means "no DES encryption"), in which case "/etc/ssl/private/nginx.key" 
#				would be encrypted with a password. However, this is almost never useful for a server installation, because you would either 
#				have to store the password on the server as well, or you'd have to enter it manually on each reboot.

# -newkey arg 	   --> this option creates a new certificate request and a new private key (arg = rsa:nbits)
# rsa:nbits   	   --> nbits is the number of bits, generate an RSA key nbits in size
# -keyout filename --> his gives the filename to write the newly created private key to
# -out filename    --> This specifies the output filename to write to or standard output by default

# -sha256   --> 	SHA is an acronym for “secure hashing algorithm".
#             		SHA256 is nothing but the SHA2 algorithm having a 256-bit length.
# -subj arg --> 	sets subject name for new request or supersedes the subject name when processing a request (CN = commonName)
RUN openssl req -newkey rsa:4096 \
			-x509 \
			-sha256 \
			-days 3650 \
			-nodes \
			-out self-signed.crt \
			-keyout self-signed.key \
			-subj "/C=DE/ST=Baden-Württemberg/L=Heilbronn/O=./OU=./CN=10.11.249.158"

# Copy nginx-config to sites-enabled. Nginx reads it from this directive.
COPY global.conf /etc/nginx/nginx.conf
COPY ./nginx.conf /etc/nginx/conf.d/server.conf
# COPY ./static_page.conf /etc/nginx/sites-available/fquist.fr

COPY ./start.sh /var/
RUN chmod +x /var/start.sh 
# uncomment to use default/static html --> also use different server config
# RUN	mkdir /template
# COPY	./my.html /template/.
# COPY	./my.html /etc/nginx/sites-available/.

EXPOSE 443
EXPOSE 444

ENTRYPOINT [ "/var/start.sh" ]

# run nginx in foreground
# ENTRYPOINT [ "nginx", "-g", "daemon off;" ]