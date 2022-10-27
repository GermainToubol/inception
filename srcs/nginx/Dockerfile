#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gtoubol <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/19 06:51:44 by gtoubol           #+#    #+#              #
#    Updated: 2022/10/26 22:22:09 by gtoubol          ###   ########.fr        #
#                                                                              #
#******************************************************************************#

# Install the preultimate version of alpine
FROM alpine:3.16

RUN apk -U upgrade; apk add nginx openssl;
RUN adduser --system --no-create-home www-data;

#COPY nginx.conf /etc/nginx/nginx.conf
#COPY blog /etc/nginx/sites-enabled/blog

EXPOSE 443
COPY hellfish.test.crt /tmp/hellfish.test.crt
COPY hellfish.test.key /tmp/hellfish.test.key

ENTRYPOINT ["nginx","-g", "daemon off;" ]
