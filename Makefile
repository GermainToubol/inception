#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gtoubol <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/18 11:00:32 by gtoubol           #+#    #+#              #
#    Updated: 2022/10/25 09:01:25 by gtoubol          ###   ########.fr        #
#                                                                              #
#******************************************************************************#

SHELL='/bin/bash'

# Start the containers
# ------------------------------------------------------------------------------
all:
	pushd ./srcs;							\
		sudo docker compose up --build -d;	\
	popd;									\

# Stop the containers
# ------------------------------------------------------------------------------
stop:
	pushd ./srcs;						\
		sudo docker compose stop;		\
	popd;

# Remove the containers
# ------------------------------------------------------------------------------
down:
	echo "Stop the containers";
	pushd ./srcs;						\
		sudo docker	compose down;		\
	popd;								\

# Clear the datas at different levels
# ------------------------------------------------------------------------------
clear-volumes: down
	echo "delete the volumes:"
	for volname in "$$(sudo docker volume ls -q)"; do	\
		if [ -n "$$volname" ]; then						\
			echo -n " - ";								\
			sudo docker volume rm $$volname;			\
		fi;												\
	done;

clear-images: down
	echo "delete the images:"
	for img in "$$(sudo docker images -q)"; do			\
		if [ -n "$$img" ]; then							\
			echo -n " - ";								\
			sudo docker rmi $$img;						\
		fi;												\
	done;

re: clear-volumes all

reset-hard: clear-images clear-volumes
	echo "reset all datas"
	sudo docker system prune -a

.PHONY: all re stop down clear-volumes clear-images resert-hard
.SILENT: all re stop down clear-volumes clear-images resert-hard
