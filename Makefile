DOCKER_COMPOSE = $(shell if command -v docker-compose >/dev/null 2>&1; then echo "docker-compose"; else echo "docker compose"; fi)

all: build

build: datadir
	$(DOCKER_COMPOSE) -f ./srcs/docker-compose.yaml build

up: datadir
	$(DOCKER_COMPOSE) -f ./srcs/docker-compose.yaml up -d
down:
	$(DOCKER_COMPOSE) -f ./srcs/docker-compose.yaml down

datadir:
	@mkdir -p ~/data/mysql/
	@mkdir -p ~/data/wordpress/
	@mkdir -p ~/data/portainer/

re: datadir
	$(DOCKER_COMPOSE) -f ./srcs/docker-compose.yaml up --build

clean:
	$(DOCKER_COMPOSE) -f ./srcs/docker-compose.yaml down -v
	docker system prune --all

fclean: clean
	sudo rm -fr ~/data

.PHONY: all build up datadir down clean re
