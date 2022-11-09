#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gtoubol <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/28 22:21:08 by gtoubol           #+#    #+#              #
#    Updated: 2022/11/09 16:00:03 by gtoubol          ###   ########.fr        #
#                                                                              #
#******************************************************************************#

FROM alpine:3.16

RUN apk -U upgrade; apk add --no-cache vsftpd openssl;

COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY conf/setup.sh /tmp/setup.sh
RUN chmod 100 /tmp/setup.sh

ENTRYPOINT ["/tmp/setup.sh"]
CMD ["vsftpd", "/etc/vsftpd/vsftpd.conf"]
