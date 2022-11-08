#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gtoubol <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/19 06:51:44 by gtoubol           #+#    #+#              #
#    Updated: 2022/11/08 21:34:56 by gtoubol          ###   ########.fr        #
#                                                                              #
#******************************************************************************#


# General requirements to run an nginx server with ssl connection.
# ------------------------------------------------------------------------------
FROM alpine:3.16 AS base
EXPOSE 443
RUN apk add --no-cache nginx openssl;

RUN adduser --system --no-create-home www-data;

COPY nginx.conf /etc/nginx/nginx.conf
ENTRYPOINT ["nginx","-g", "daemon off;" ]

# Mandatory part
# ------------------------------------------------------------------------------
FROM base AS nginx-mandatory
COPY blog /etc/nginx/sites-enabled/blog

# Bonus part
# ------------------------------------------------------------------------------
FROM nginx-mandatory AS nginx-bonus
COPY adminer /etc/nginx/sites-enabled/adminer
COPY static /etc/nginx/sites-enabled/static
