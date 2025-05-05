FROM alpine:3.20

RUN apk update && apk add --no-cache \
    curl \
    ca-certificates

RUN mkdir -p /test
WORKDIR /test
RUN curl -L https://github.com/portainer/portainer/releases/download/2.27.1/portainer-2.27.1-linux-amd64.tar.gz -o portainer.tar.gz \
    && tar -xzf portainer.tar.gz \
    && mv portainer/* /usr/local/bin/

COPY ./tools/healthcheck.sh /usr/local/bin/healthcheck.sh
RUN chmod +x /usr/local/bin/healthcheck.sh

COPY ./tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh


CMD ["/usr/local/bin/setup.sh"]
