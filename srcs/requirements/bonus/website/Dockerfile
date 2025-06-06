FROM alpine:3.20

RUN apk update && apk add --no-cache \
	nginx \
	&& rm -fr /var/cache/apk/*;



RUN mkdir -p /var/www/html;
RUN mkdir -p /run/nginx;
RUN mkdir -p /var/log/nginx;
COPY /content/ /var/www/html

COPY /conf/nginx.conf /etc/nginx/nginx.conf


COPY /tools/healthcheck.sh /usr/local/bin/healthcheck.sh

RUN chmod +x /usr/local/bin/healthcheck.sh;

RUN chown -R nginx:nginx /var/www/html \
	&& chown -R nginx:nginx /var/log/nginx;

EXPOSE 9090

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
