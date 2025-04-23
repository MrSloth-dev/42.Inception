
all: build

build: datadir
	docker compose -f ./srcs/docker-compose.yaml build

up: datadir
	docker compose -f ./srcs/docker-compose.yaml up -d
down:
	docker compose -f ./srcs/docker-compose.yaml down

datadir:
	@mkdir -p ~/data/mysql/
	@mkdir -p ~/data/wordpress/
	@mkdir -p ~/data/prometheus/
	@mkdir -p ~/data/grafana/

re: datadir
	docker compose -f ./srcs/docker-compose.yaml up --build

clean:
	docker compose -f ./srcs/docker-compose.yaml down -v
	docker system prune --all

fclean: clean
	sudo rm -fr ~/data

.PHONY: all build up datadir down clean re
