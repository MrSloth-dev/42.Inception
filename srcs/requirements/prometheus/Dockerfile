FROM alpine:3.16

RUN apk update && apk add --no-cache \
    prometheus \
    curl \
    netcat-openbsd \
    && rm -fr /var/cache/apk/*;

RUN mkdir -p /etc/prometheus /prometheus \

COPY ./conf/prometheus.yml /etc/prometheus/prometheus.yml

COPY ./tools/healthcheck.sh /usr/local/bin/healthcheck.sh
RUN chmod u+x usr/local/bin/healthcheck.sh 

COPY ./tools/setup.sh /usr/local/bin/setup.sh
RUN chmod u+x usr/local/bin/setup.sh 

EXPOSE 9090

CMD [ "/usr/local/bin/setup.sh" ] 
