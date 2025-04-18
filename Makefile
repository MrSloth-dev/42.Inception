
all: build

build: datadir
	docker compose -f ./srcs/docker-compose.yaml build

up: datadir
	docker compose -f ./srcs/docker-compose.yaml up
down:
	docker compose -f ./srcs/docker-compose.yaml down

datadir:
	@mkdir -p ~/data/mysql/
	@mkdir -p ~/data/wordpress/

clean:
	docker compose -f ./srcs/docker-compose.yaml down -v
	docker system prune --all

.PHONY: all build up datadir down clean
