FROM alpine:3.16

RUN apk update && apk add --no-cache \
    curl \
    netcat-openbsd \
    ca-certificates \
    && rm -fr /var/cache/apk/*;

RUN mkdir -p /data /etc/portainer;

RUN curl -L https://github.com/portainer/portainer/releases/download/2.27.1/portainer-2.27.1-linux-amd64.tar.gz -o portainer.tar.gz \
    && tar -xzf portainer.tar.gz \
    && mv portainer/portainer /usr/local/bin/ \
    && mv portainer/public /usr/local/lib/portainer \
    && rm -rf portainer portainer.tar.gz

COPY ./tools/healthcheck.sh /usr/local/bin/healthcheck.sh
RUN chmod u+x usr/local/bin/healthcheck.sh 

COPY ./tools/setup.sh /usr/local/bin/setup.sh
RUN chmod u+x usr/local/bin/setup.sh 

VOLUME /data

EXPOSE 9000

CMD [ "/usr/local/bin/setup.sh" ] 

