#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gtoubol <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/18 11:00:32 by gtoubol           #+#    #+#              #
#    Updated: 2022/10/19 00:23:00 by gtoubol          ###   ########.fr        #
#                                                                              #
#******************************************************************************#

SHELL='/bin/bash'

all:
	@pushd ./srcs;						\
	sudo docker compose up --build -d;	\
	popd;								\

clean:
	@pushd ./srcs;						\
	sudo docker	compose down;			\
	popd;								\

fclean: clean
	sudo docker volume rm wp-data db-data
