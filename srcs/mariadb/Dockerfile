#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gtoubol <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/19 06:51:48 by gtoubol           #+#    #+#              #
#    Updated: 2022/10/26 00:22:37 by gtoubol          ###   ########.fr        #
#                                                                              #
#******************************************************************************#
FROM alpine:3.16

RUN apk -U upgrade; apk add mariadb mariadb-client;
COPY ./mariadb.conf /etc/my.cnf
RUN chown -R mysql:mysql /var/lib/mysql;\
	mysql_install_db --user=mysql;

COPY ./setup.sh /tmp/setup.sh

ARG MDB_USER
ARG MDB_PASSWD

RUN sh /tmp/setup.sh "${MDB_USER}" "${MDB_PASSWD}"
RUN mysql_install_db --user=root;\
	chown -R mysql:mysql /var/lib/mysql;


ENTRYPOINT ["/usr/bin/mysqld", "-u", "mysql"]
