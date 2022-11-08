#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gtoubol <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/19 07:40:11 by gtoubol           #+#    #+#              #
#    Updated: 2022/11/04 19:04:39 by gtoubol          ###   ########.fr        #
#                                                                              #
#******************************************************************************#
FROM alpine:3.16

# Download the tools
# ------------------------------------------------------------------------------
RUN apk -U upgrade; \
	apk add --no-cache php php-fpm php-opcache; \
	apk add --no-cache php-gd php-mysqli php-zlib php-curl php-phar php-iconv;\
	apk add --no-cache php-tokenizer php8-redis php-ctype;
RUN	apk add --no-cache mariadb-client redis;\
	rm /etc/php8/php-fpm.d/*

# Download wordpress
# ------------------------------------------------------------------------------
RUN wget "http://fr.wordpress.org/latest-fr_FR.tar.gz";\
	tar xzf latest-fr_FR.tar.gz;\
	mkdir -p /var/www/blog;\
	cp -R wordpress/* /var/www/blog;\
	rm latest-fr_FR.tar.gz; \
	adduser --system --no-create-home www-data;\
	chown -R www-data:www-data /var/www/blog;

COPY blog.conf /etc/php8/php-fpm.d/blog.conf

# Get the tools to configure wordpress inside the database
# ------------------------------------------------------------------------------
RUN wget "https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar";\
	chmod +x wp-cli.phar; \
	mv wp-cli.phar /usr/local/bin/wp;

COPY setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh

ENTRYPOINT ["/bin/sh", "/tmp/setup.sh"]
CMD ["/usr/sbin/php-fpm8", "-F"]
