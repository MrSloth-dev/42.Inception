FROM alpine:3.16

RUN apk update && apk add --no-cache \
		php8 \
		php8-session \
		php8-mysqli \
		php8-pdo \
		php8-pdo_mysql \
		php8-json \
		php8-mbstring \
		nginx \
		php8-fpm;

RUN apk add --no-cache curl;
RUN rm -fr /var/cache/apk/*;

RUN mkdir -p /var/run/php;
RUN sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/g' /etc/php8/php-fpm.d/www.conf;

RUN mkdir -p /var/www/html && \
    curl -L https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -o /var/www/html/index.php;

COPY ./conf/nginx.conf /etc/nginx/http.d/default.conf

COPY ./tools/healthcheck.sh /usr/local/bin/healthcheck.sh
RUN chmod u+x usr/local/bin/healthcheck.sh 

COPY ./tools/setup.sh /usr/local/bin/setup.sh
RUN chmod u+x usr/local/bin/setup.sh 

EXPOSE 8080

CMD [ "/usr/local/bin/setup.sh" ] 

