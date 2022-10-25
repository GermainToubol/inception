#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gtoubol <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/19 07:40:11 by gtoubol           #+#    #+#              #
#    Updated: 2022/10/25 09:46:36 by gtoubol          ###   ########.fr        #
#                                                                              #
#******************************************************************************#
FROM alpine:3.16

# Download the tools
# ------------------------------------------------------------------------------
RUN apk -U upgrade; \
	apk add --no-cache php php-fpm php-opcache; \
	apk add --no-cache php-gd php-mysqli php-zlib php-curl php-phar php-iconv;\
	rm /etc/php8/php-fpm.d/*

# Download wordpress
# ------------------------------------------------------------------------------
RUN wget "http://fr.wordpress.org/latest-fr_FR.tar.gz";\
	tar xzf latest-fr_FR.tar.gz;\
	mkdir -p /var/www;\
	mv wordpress /var/www/blog;\
	rm latest-fr_FR.tar.gz; \
	adduser --system --no-create-home www-data;\
	chown -R www-data:www-data /var/www/blog;

COPY blog.conf /etc/php8/php-fpm.d/blog.conf
COPY wp-confbase.php /var/www/blog/wp-confbase.php

# Configure the access to the database
# ------------------------------------------------------------------------------
ARG MDB_USER
ARG MDB_PASSWD
RUN cd /var/www/blog; cat wp-confbase.php | sed -e "s/WP_DBUSER/${MDB_USER}/g" \
	-e "s/WP_DBPASS/${MDB_PASSWD}/g" > wp-config.php

# Get the tools to configure wordpress inside the database
# ------------------------------------------------------------------------------
COPY setup.sh /tmp/setup.sh
RUN wget "https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar";\
	chmod +x wp-cli.phar; \
	mv wp-cli.phar /usr/local/bin/wp;

ENTRYPOINT ["/bin/sh", "/tmp/setup.sh"]
CMD ["/usr/sbin/php-fpm8", "-F"]
