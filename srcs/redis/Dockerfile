#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gtoubol <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/27 11:57:26 by gtoubol           #+#    #+#              #
#    Updated: 2022/10/28 16:00:04 by gtoubol          ###   ########.fr        #
#                                                                              #
#******************************************************************************#

FROM alpine:3.16

ARG REDIS_PASSWD
ENV REDIS_PASSWD=${REDIS_PASSWD}

RUN apk -U upgrade; apk add --no-cache redis;
RUN echo maxmemory 256mb >> /etc/redis.conf;\
	echo maxmemory-policy allkeys-lru >> /etc/redis.conf;\
	echo "masterauth ${REDIS_PASSWD}" >> /etc/redis.conf;\
	echo masteruser user >> /etc/redis.conf;\
	echo "requirepass ${REDIS_PASSWD}" >> /etc/redis.conf;\
	echo "bind 0.0.0.0" >> /etc/redis.conf;

# add passwd to redis

ENTRYPOINT ["redis-server", "--protected-mode", "no"] #, "--requirepass", "${REDIS_PASSWD}"] #, "--protected-mode", "no"]
