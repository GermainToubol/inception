#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gtoubol <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/18 11:00:32 by gtoubol           #+#    #+#              #
#    Updated: 2022/10/28 12:57:44 by gtoubol          ###   ########.fr        #
#                                                                              #
#******************************************************************************#

SHELL	= '/bin/bash'
DOMAIN	= gtoubol.42paris.fr
CERT	= $(addprefix ./srcs/cert_utils/$(DOMAIN), .cnf .crt .csr .key)
MAND	= ./srcs
BONUS	= ./bonus

DIR = $(BONUS)

# Start the containers
# ------------------------------------------------------------------------------
all:
	mkdir -p $${HOME}/data/{wp-data,db-data}
	pushd $(DIR);							\
		pushd ./cert_utils;					\
			yes "no" | ./utils.sh $(DOMAIN);\
		popd;								\
		sudo docker compose up --build --force-recreate -d;	\
	popd;									\

# Stop the containers
# ------------------------------------------------------------------------------
stop:
	pushd $(DIR);						\
		sudo docker compose stop;		\
	popd;

# Remove the containers
# ------------------------------------------------------------------------------
down:
	echo "Stop the containers";
	pushd $(DIR);						\
		sudo docker	compose down;		\
	popd;								\

# Clear the datas at different levels
# ------------------------------------------------------------------------------
clear-site-keys:	down
	echo "delete the site keys"
	rm -f $(CERT)

clear-volumes: down
	echo "delete the volumes:"
	for volname in $$(sudo docker volume ls -q); do	\
		if [ -n "$$volname" ]; then					\
			echo -n " - ";							\
			sudo docker volume rm $$volname;		\
		fi;											\
	done;
	sudo rm -rf ${HOME}/data

clear-images: down
	echo "delete the images:"
	for img in "$$(sudo docker images -q)"; do		\
		if [ -n "$$img" ]; then						\
			echo -n " - ";							\
			sudo docker rmi $$img;					\
		fi;											\
	done;

fclean: clear-volumes

re: fclean all

reset-hard: clear-images clear-volumes
	echo "reset all datas"
	sudo docker system prune -a

.PHONY: all re stop down clear-site-keys clear-volumes
.PHONY: clear-images fclean re resert-hard
.SILENT: all re stop down clear-site-keys clear-volumes
.SILENT: clear-images fclean re resert-hard
