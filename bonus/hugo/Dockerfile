#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gtoubol <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/02 20:23:49 by gtoubol           #+#    #+#              #
#    Updated: 2022/11/08 17:36:44 by gtoubol          ###   ########.fr        #
#                                                                              #
#******************************************************************************#

FROM alpine:3.16
RUN apk add hugo git;
RUN apk add nginx;
RUN mkdir -p /var/www/public
RUN mkdir -p /hugo

# Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Hugo
COPY hugo /etc/nginx/sites-enabled/hugo
COPY config.toml /tmp/
COPY setup.sh /tmp/setup.sh

ENTRYPOINT ["/bin/sh", "/tmp/setup.sh"]
CMD ["nginx", "-g", "daemon off;"]
