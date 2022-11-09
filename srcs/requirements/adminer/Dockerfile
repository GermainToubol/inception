#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gtoubol <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/31 18:29:25 by gtoubol           #+#    #+#              #
#    Updated: 2022/11/09 15:52:24 by gtoubol          ###   ########.fr        #
#                                                                              #
#******************************************************************************#

FROM alpine:3.16

RUN apk add --no-cache php8 php8-fpm php-mysqli mariadb-client php-session;
RUN wget "https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-en.php";\
	mkdir -p /var/www/adminer;\
	mv adminer-4.8.1-en.php /var/www/adminer/adminer.php;

RUN adduser --system --no-create-home www-data;\
	chown -R www-data:www-data /var/www/adminer;\
	chmod +x /var/www/adminer/adminer.php

RUN touch /var/log/fpm-php.www.log && chmod 666 /var/log/fpm-php.www.log

COPY conf/adminer.conf /etc/php8/php-fpm.d/adminer.conf
ENTRYPOINT ["/usr/sbin/php-fpm8", "-F"]
