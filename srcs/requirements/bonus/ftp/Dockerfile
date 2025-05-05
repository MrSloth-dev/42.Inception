FROM alpine:3.16

RUN apk update && apk add --no-cache \
    vsftpd \
    bash \
    netcat-openbsd \
    && rm -fr /var/cache/apk/*;

RUN mkdir -p /var/run/vsftpd/empty \
    && mkdir -p /var/ftp/pub

COPY ./conf/vsftpd.conf /etc/vsftpd/vsftpd.conf

COPY ./tools/healthcheck.sh /usr/local/bin/healthcheck.sh
RUN chmod u+x usr/local/bin/healthcheck.sh 

COPY ./tools/setup.sh /usr/local/bin/setup.sh
RUN chmod u+x usr/local/bin/setup.sh 

EXPOSE 20 21 21100-21110

CMD [ "/usr/local/bin/setup.sh" ] 
