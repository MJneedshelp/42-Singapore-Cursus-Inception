NAME=inception

up:
	docker compose -f srcs/docker-compose.yml up -d --build

down:
	docker compose -f srcs/docker-compose.yml down

re:
	down up

clean:
	docker system prune -af --volumes
