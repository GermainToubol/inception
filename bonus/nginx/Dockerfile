#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gtoubol <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/19 06:51:44 by gtoubol           #+#    #+#              #
#    Updated: 2022/11/08 06:54:46 by gtoubol          ###   ########.fr        #
#                                                                              #
#******************************************************************************#

# Install the preultimate version of alpine
FROM alpine:3.16

RUN apk -U upgrade; apk add nginx openssl;
RUN adduser --system --no-create-home www-data;

COPY nginx.conf /etc/nginx/nginx.conf
COPY blog /etc/nginx/sites-enabled/blog
COPY adminer /etc/nginx/sites-enabled/adminer
COPY static /etc/nginx/sites-enabled/static

EXPOSE 443

ENTRYPOINT ["nginx","-g", "daemon off;" ]
