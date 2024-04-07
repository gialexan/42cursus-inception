# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gilmar <gilmar@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/03/25 21:54:07 by gilmar            #+#    #+#              #
#    Updated: 2024/04/07 19:18:26 by gilmar           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

################################################################################
#							General Configurations							   #
################################################################################

LOGIN=$(shell grep 'LOGIN=' srcs/.env | cut -d'=' -f2 | xargs)
DOCKER_COMPOSE = docker-compose -f srcs/docker-compose.yml
VOLUMES = "/home/$(LOGIN)/data"

################################################################################
#							Service Management						     	   #
################################################################################

up:
	sudo mkdir -p "$(VOLUMES)/wordpress" "$(VOLUMES)/mariadb"
	$(DOCKER_COMPOSE) up -d --build

down:
	$(DOCKER_COMPOSE) down

start:
	$(DOCKER_COMPOSE) start

stop:
	$(DOCKER_COMPOSE) stop

shell:
	@read -p "=> Enter service: " service; \
	$(DOCKER_COMPOSE) exec -it $$service /bin/sh

## Status
ps:
	$(DOCKER_COMPOSE) ps

## Logs
logs:
	$(DOCKER_COMPOSE) logs

################################################################################
#								Cleanup Section						     	   #
################################################################################

## Stop and Remove Containers
clean:
	$(DOCKER_COMPOSE) down --rmi all --volumes

## Full Cleanup (Remove Images and Volumes)
fclean: clean
	sudo rm -rf $(VOLUMES)

## Deep Cleanup (Remove Unused Objects)
prune: fclean
	docker system prune --all --force --volumes

.PHONY: shell up down start stop ps clean fclean prune
