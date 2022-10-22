#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gtoubol <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/18 11:00:32 by gtoubol           #+#    #+#              #
#    Updated: 2022/10/22 16:54:22 by gtoubol          ###   ########.fr        #
#                                                                              #
#******************************************************************************#

SHELL='/bin/bash'

all:
	@pushd ./srcs;						\
	sudo docker compose up --build --force-recreate -d;	\
	popd;								\

clean:
	@pushd ./srcs;						\
	sudo docker	compose down;			\
	popd;								\

fclean: clean
	sudo docker volume rm wp-data db-data
	sudo docker rmi $$(sudo docker images -q)

re: fclean all
