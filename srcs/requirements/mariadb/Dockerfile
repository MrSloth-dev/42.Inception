FROM debian:bullseye

RUN apt-get update && \
	apt-get install -y mariadb-server

COPY ./conf/ /etc/mysql/conf.d/

COPY ./tools/setup.sh /tmp/setup.sh

EXPOSE 3306

CMD [ "sh", /tmp/setup.sh ]
