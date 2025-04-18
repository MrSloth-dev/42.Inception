FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
	net-tools \
	php7.4-fpm \
	php7.4-sqli \
	php7.4-mysql \
	php7.4-curl \
	php7.4-gd \
	php7.4-xml \
	php7.4-mbstring \
	mariadb-client;

RUN apt-get install -y wget;
RUN apt-get install -y curl;

RUN apt-get clean \
	&& rm -rf /var/lib/apt/lists/*;

RUN mkdir -p /var/run/php;

WORKDIR /var/www/html

RUN wget https://wordpress.org/latest.tar.gz \
	&& tar -zxf latest.tar.gz \
	&& mv wordpress/* . \
	&& rm -fr wordpress latest.tar.gz \
	&& find /var/www/html -type d -exec chmod 755 {} \;\
	&& find /var/www/html -type f -exec chmod 644 {} \;\
	&& chown -R www-data:www-data /var/www/html;

RUN mkdir -p /run/php/ \
	&& sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf \
	&& sed -i 's/;clear_env = no/clear_env = no/g' /etc/php/7.4/fpm/pool.d/www.conf;

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp;



COPY /conf/www.cnf /etc/php/7.4/fpm/pool.d/www.conf

COPY /tools/healthcheck.sh /usr/local/bin/healthcheck.sh
COPY /tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/healthcheck.sh

EXPOSE 9000

ENTRYPOINT [ "setup.sh" ]
