FROM alpine:3.16

RUN apk update && apk add --no-cache \
    curl \
    netcat-openbsd \
    && rm -fr /var/cache/apk/*;

RUN mkdir -p /etc/grafana /grafana

COPY ./conf/grafana.yml /etc/grafana/grafana.yml

COPY ./tools/healthcheck.sh /usr/local/bin/healthcheck.sh
RUN chmod u+x usr/local/bin/healthcheck.sh 

COPY ./tools/setup.sh /usr/local/bin/setup.sh
RUN chmod u+x usr/local/bin/setup.sh 

EXPOSE 3000

CMD [ "/usr/local/bin/setup.sh" ] 
