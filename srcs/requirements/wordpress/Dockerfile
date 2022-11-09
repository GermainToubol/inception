#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gtoubol <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/19 07:40:11 by gtoubol           #+#    #+#              #
#    Updated: 2022/11/09 18:19:56 by gtoubol          ###   ########.fr        #
#                                                                              #
#******************************************************************************#

# General Requirements
# ------------------------------------------------------------------------------
FROM alpine:3.15 AS base

# Download the tools
# -------------------------------
RUN apk -U upgrade; apk add --no-cache php8 php8-fpm php8-opcache; \
	apk add --no-cache php8-gd php8-mysqli php8-zlib php8-curl php8-phar php8-iconv;\
	apk add --no-cache php8-tokenizer php8-redis php8-ctype php8-json;\
	apk add --no-cache mariadb-client redis;\
	ln -s /usr/bin/php8 /bin/php;\
	rm -f /etc/php8/php-fpm.d/*

# Download wordpress
# -------------------------------
RUN wget "http://fr.wordpress.org/latest-fr_FR.tar.gz";\
	tar xzf latest-fr_FR.tar.gz;\
	mkdir -p /var/www/blog;\
	cp -R wordpress/* /var/www/blog;\
	rm latest-fr_FR.tar.gz; \
	adduser --system --no-create-home www-data;\
	chown -R www-data:www-data /var/www/blog;

# Get the tools to configure wordpress inside the database
# -------------------------------
RUN wget "https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar";\
	chmod +x wp-cli.phar; \
	mv wp-cli.phar /usr/local/bin/wp;

# Mandatory
# ------------------------------------------------------------------------------
FROM base AS wordpress-mandatory

COPY config/blog.conf /etc/php8/php-fpm.d/blog.conf
COPY config/setup_mandatory.sh /tmp/setup.sh

ENTRYPOINT ["/bin/sh", "/tmp/setup.sh"]
CMD ["/usr/sbin/php-fpm8", "-F"]

# Bonus
# ------------------------------------------------------------------------------
FROM wordpress-mandatory AS wordpress-bonus
COPY config/setup_bonus.sh /tmp/setup.sh

ENTRYPOINT ["/bin/sh", "/tmp/setup.sh"]
CMD ["/usr/sbin/php-fpm8", "-F"]
