#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gtoubol <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/19 06:51:48 by gtoubol           #+#    #+#              #
#    Updated: 2022/11/09 16:14:11 by gtoubol          ###   ########.fr        #
#                                                                              #
#******************************************************************************#

# General requirements
# ------------------------------------------------------------------------------
FROM alpine:3.16 AS base

RUN apk -U upgrade; apk add --no-cache mariadb mariadb-client;
COPY conf/mariadb.conf /etc/my.cnf
RUN chown -R mysql:mysql /var/lib/mysql;\
	mysql_install_db --user=mysql;

# Mandatory
# ------------------------------------------------------------------------------
FROM base AS mariadb-mandatory
COPY conf/setup_mandatory.sh /tmp/setup.sh
RUN chown -R mysql:mysql /var/lib/mysql;

ENTRYPOINT ["/bin/sh", "/tmp/setup.sh"]
CMD ["/usr/bin/mysqld", "-u", "mysql"]

# Bonus
# ------------------------------------------------------------------------------
FROM mariadb-mandatory AS mariadb-bonus
COPY conf/setup_bonus.sh /tmp/setup.sh
RUN chown -R mysql:mysql /var/lib/mysql;

ENTRYPOINT ["/bin/sh", "/tmp/setup.sh"]
CMD ["/usr/bin/mysqld", "-u", "mysql"]
