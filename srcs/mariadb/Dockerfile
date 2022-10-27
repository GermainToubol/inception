#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gtoubol <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/19 06:51:48 by gtoubol           #+#    #+#              #
#    Updated: 2022/10/26 10:18:12 by gtoubol          ###   ########.fr        #
#                                                                              #
#******************************************************************************#
FROM alpine:3.16

RUN apk -U upgrade; apk add mariadb mariadb-client;
COPY ./mariadb.conf /etc/my.cnf
RUN chown -R mysql:mysql /var/lib/mysql;\
	mysql_install_db --user=mysql;

COPY ./setup.sh /tmp/setup.sh
RUN chown -R mysql:mysql /var/lib/mysql;

ENTRYPOINT ["/bin/sh", "/tmp/setup.sh"]
CMD ["/usr/bin/mysqld", "-u", "mysql"]
