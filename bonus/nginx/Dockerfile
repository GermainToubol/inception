#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gtoubol <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/19 06:51:44 by gtoubol           #+#    #+#              #
#    Updated: 2022/11/04 18:47:44 by gtoubol          ###   ########.fr        #
#                                                                              #
#******************************************************************************#

# Install the preultimate version of alpine
FROM alpine:3.16

RUN apk -U upgrade; apk add nginx openssl nginx-mod-stream;
RUN adduser --system --no-create-home www-data;

COPY nginx.conf /etc/nginx/nginx.conf
COPY blog /etc/nginx/sites-enabled/blog
COPY ftp_service /etc/nginx/conf.d/ftp_service

EXPOSE 443

ENTRYPOINT ["nginx","-g", "daemon off;" ]
