
FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
	mariadb-server \
	mariadb-client;

RUN apt-get clean \
	&& rm -rf /var/lib/apt/lists/*;


RUN mkdir -p /var/run/mysqld && \
	chown -R mysql:mysql /var/run/mysqld && \
	chown -R mysql:mysql /var/lib/mysql;

RUN mkdir -p /home/${USER}/data/mysql;
RUN mkdir -p /home/${USER}/data/wordpress;

COPY ./tools/healthcheck.sh /usr/local/bin/healthcheck.sh

COPY /conf/my.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/setup.sh /usr/local/bin/setup.sh

RUN chmod +x /usr/local/bin/healthcheck.sh
RUN chmod +x /usr/local/bin/setup.sh

EXPOSE 3306

ENTRYPOINT [ "setup.sh" ]
