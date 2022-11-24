# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fquist <fquist@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/15 11:00:58 by fquist            #+#    #+#              #
#    Updated: 2022/11/24 14:05:26 by fquist           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# create volumes and run docker network
all:
	mkdir -p /home/fquist/data/mariadb
	mkdir -p /home/fquist/data/wordpress
	mkdir -p /home/fquist/data/static
	sudo docker-compose -f ./srcs/docker-compose.yml up --build -d
	

clean:
	sudo docker-compose -f ./srcs/docker-compose.yml down

# delete volumes from local storage
fclean: clean
	sudo docker-compose -f ./srcs/docker-compose.yml down --volumes --rmi all
	sudo rm -rf /home/fquist/data

re: clean all

# run containers independently
nginx:
	sudo docker-compose -f ./srcs/docker-compose.yml build nginx

wordpress:
	sudo docker-compose -f ./srcs/docker-compose.yml build wordpress

mariadb:
	sudo docker-compose -f ./srcs/docker-compose.yml build mariadb

redis:
	sudo docker-compose -f ./srcs/docker-compose.yml build redis

ftp:
	sudo docker-compose -f ./srcs/docker-compose.yml build ftp

show_log_service:
	sudo docker container exec -it log_c bash -ci "cat ftp_log"
	sudo docker container exec -it log_c bash -ci "cat mariadb_log"
	sudo docker container exec -it log_c bash -ci "cat nginx_log"
	sudo docker container exec -it log_c bash -ci "cat redis_log"
	sudo docker container exec -it log_c bash -ci "cat static_log"
	sudo docker container exec -it log_c bash -ci "cat wordpress_log"
	sudo docker container exec -it log_c bash -ci "cat adminer_log"
	


# delete all containers and images
delete: clean
	sudo docker container prune -f
	sudo docker rmi $$(sudo docker images -q)

# show images and containers
show:
	@echo "\033[1;34mCONTAINERS:\033[0m"
	sudo docker container ls -a
	@echo "\033[1;35mIMAGES:\033[0m"
	sudo docker image ls -a

# enter containers
#  -t, --tty           # interactive
#  -i, --interactive   # stdin
wp_exe:
	sudo docker exec -it wordpress_c bash

db_exe:
	sudo docker exec -it mariadb_c bash

nginx_exe:
	sudo docker exec -it nginx_c bash

redis_exe:
	sudo docker exec -it redis_c bash

ftp_exe:
	sudo docker exec -it ftp_c bash

log:
	docker compose -f ./srcs/docker-compose.yml logs