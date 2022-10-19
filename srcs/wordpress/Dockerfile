#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gtoubol <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/19 07:40:11 by gtoubol           #+#    #+#              #
#    Updated: 2022/10/19 07:40:33 by gtoubol          ###   ########.fr        #
#                                                                              #
#******************************************************************************#
FROM alpine:3.16

# Download wordpress
RUN mkdir /var/www;\
	cd /var/www;\
	wget "http://fr.wordpress.org/latest-fr_FR.tar.gz";\
	tar xzf latest-fr_FR.tar.gz;\
	mv wordpress blog;\
	rm latest-fr_FR.tar.gz;

# Download the tools
RUN apk -U upgrade; \
	apk add php php-fpm php-opcache; \
	apk add php-gd php-mysqli php-zlib php-curl; \
	rm /etc/php8/php-fpm.d/*

RUN adduser --system --no-create-home www-data;\
	chown -R www-data:www-data /var/www/blog;

COPY blog.conf /etc/php8/php-fpm.d/blog.conf

ENTRYPOINT ["php-fpm8", "-F"]
