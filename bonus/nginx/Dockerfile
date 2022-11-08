#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gtoubol <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/19 06:51:44 by gtoubol           #+#    #+#              #
#    Updated: 2022/11/08 20:51:23 by gtoubol          ###   ########.fr        #
#                                                                              #
#******************************************************************************#

EXPOSE 443

# General requirements to run an nginx server with ssl connection.
# ------------------------------------------------------------------------------
FROM alpine:3.16 AS base
RUN apk --no-cache add nginx openssl;

RUN adduser --system --no-create-home www-data;

COPY nginx.conf /etc/nginx/nginx.conf
ENTRYPOINT ["nginx","-g", "daemon off;" ]

# Mandatory part
# ------------------------------------------------------------------------------
FROM base AS nginx-mandatory
COPY blog /etc/nginx/sites-enabled/blog	# Only add wordpress configuration

# Bonus part
# ------------------------------------------------------------------------------
FROM nginx-mandatory AS nginx-bonus
COPY adminer /etc/nginx/sites-enabled/adminer # Adminer redirection
COPY static /etc/nginx/sites-enabled/static	  # Hugo redirection
