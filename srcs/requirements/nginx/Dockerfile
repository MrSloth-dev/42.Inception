FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
	nginx \
	openssl \
	procps \
	net-tools;
RUN apt-get install -y wget;
RUN apt-get install -y curl;

RUN apt-get clean \
	&& rm -rf /var/lib/apt/lists/*;


RUN mkdir -p /etc/nginx/ssl;

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/nginx.key \ 
	-out /etc/nginx/ssl/nginx.crt \ 
	-subj "/C=PT/ST=Porto/L=Porto/O=42porto/CN=joao-pol.42.fr"






COPY /conf/nginx.conf /etc/nginx/nginx.conf
COPY /conf/default.conf /etc/nginx/conf.d/default.conf
COPY /conf/adminer.conf /etc/nginx/conf.d/adminer.conf

RUN mkdir -p /var/run/nginx;

COPY /tools/healthcheck.sh /usr/local/bin/healthcheck.sh


RUN chmod +x /usr/local/bin/healthcheck.sh
EXPOSE 443

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
