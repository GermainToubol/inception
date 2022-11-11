#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gtoubol <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/19 06:51:44 by gtoubol           #+#    #+#              #
#    Updated: 2022/11/11 20:18:23 by gtoubol          ###   ########.fr        #
#                                                                              #
#******************************************************************************#


# General requirements to run an nginx server with ssl connection.
# ------------------------------------------------------------------------------
FROM alpine:3.15 AS base

EXPOSE 443

RUN apk add --no-cache nginx openssl;
RUN adduser --system --no-create-home www-data;

COPY config/nginx.conf /etc/nginx/nginx.conf
ENTRYPOINT ["nginx","-g", "daemon off;" ]

# Mandatory part
# ------------------------------------------------------------------------------
FROM base AS nginx-mandatory
COPY config/blog /etc/nginx/sites-enabled/blog

# Bonus part
# ------------------------------------------------------------------------------
FROM nginx-mandatory AS nginx-bonus
COPY config/adminer /etc/nginx/sites-enabled/adminer
COPY config/static /etc/nginx/sites-enabled/static
COPY config/jupyterhub /etc/nginx/sites-enabled/jupyterhub
