#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gtoubol <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/02 20:23:49 by gtoubol           #+#    #+#              #
#    Updated: 2022/11/02 21:23:52 by gtoubol          ###   ########.fr        #
#                                                                              #
#******************************************************************************#

FROM alpine:3.16
RUN apk add hugo;
RUN mkdir -p /var/www/public

COPY setup.sh /tmp/setup.sh

ENTRYPOINT ["/bin/sh", "/tmp/setup.sh"]
CMD ["hugo", "serve", "-s", "/var/www/public", "--bind=hugo.mandatory", "--baseURL=gtoubol.42paris.fr/hugo"]
