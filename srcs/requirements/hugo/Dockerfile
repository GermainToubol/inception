#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gtoubol <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/02 20:23:49 by gtoubol           #+#    #+#              #
#    Updated: 2022/11/09 16:35:59 by gtoubol          ###   ########.fr        #
#                                                                              #
#******************************************************************************#

FROM alpine:3.15
RUN apk add --no-cache hugo git nginx;
RUN mkdir -p /var/www/public /hugo;

# Nginx
COPY config/nginx/nginx.conf /etc/nginx/nginx.conf

# Hugo
COPY config/nginx/hugo /etc/nginx/sites-enabled/hugo
COPY config/hugo/config.toml /tmp/config.toml
COPY content /tmp/content
COPY config/setup.sh /tmp/setup.sh

ENTRYPOINT ["/bin/sh", "/tmp/setup.sh"]
CMD ["nginx", "-g", "daemon off;"]
