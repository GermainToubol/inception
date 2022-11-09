#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gtoubol <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/28 22:21:08 by gtoubol           #+#    #+#              #
#    Updated: 2022/10/31 18:01:46 by gtoubol          ###   ########.fr        #
#                                                                              #
#******************************************************************************#

FROM alpine:3.16

RUN apk -U upgrade; apk add vsftpd openssl;

COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY setup.sh /tmp/setup.sh
RUN chmod u+x /tmp/setup.sh

ENTRYPOINT ["/tmp/setup.sh"]
CMD ["vsftpd", "/etc/vsftpd/vsftpd.conf"]
