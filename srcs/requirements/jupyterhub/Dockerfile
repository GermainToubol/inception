#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gtoubol <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/11 14:49:19 by gtoubol           #+#    #+#              #
#    Updated: 2022/11/11 23:50:57 by gtoubol          ###   ########.fr        #
#                                                                              #
#******************************************************************************#

FROM alpine:3.16.1

# Installing all prerequisites for jupyterhub
RUN apk update; apk add --no-cache py3-pip py3-alembic py3-async_generator py3-openssl\
	py3-jinja2 py3-jsonschema py3-ruamel.yaml py3-oauthlib py3-packaging\
	py3-prometheus-client py3-requests py3-sqlalchemy py3-greenlet py3-tornado py3-wheel py3-traitlets\
	nodejs npm;

RUN pip install --no-cache jupyterhub; npm install -g configurable-http-proxy;
RUN apk add --no-cache jupyter-notebook linux-pam; pip install --no-cache jupyterlab notebook;

COPY setup.sh /tmp/setup.sh
COPY ./jupyterhub-config.py /etc/jupyterhub-config.py

ENTRYPOINT ["/bin/sh", "/tmp/setup.sh"]
CMD ["jupyterhub"]
