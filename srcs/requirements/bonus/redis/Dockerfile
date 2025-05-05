FROM alpine:3.20

RUN apk update && apk add --no-cache \
	redis \
	&& rm -fr /var/cache/apk/*

COPY ./conf/redis.conf /etc/redis.conf
COPY ./tools/healthcheck.sh /usr/local/bin/healthcheck.sh
RUN chmod u+x usr/local/bin/healthcheck.sh 

COPY ./tools/setup.sh /usr/local/bin/setup.sh
RUN chmod u+x usr/local/bin/setup.sh 

EXPOSE 6379


CMD ["/usr/local/bin/setup.sh"]
