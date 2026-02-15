NAME=inception
START_MESSAGE= $(NAME) is up. "An idea is like a virus"
COMPOSE = docker compose
COMPOSE_FILE = srcs/docker-compose.yml
.DEFAULT_GOAL := all

# Build the images + start containers
all: build up print_art
	@echo '$(START_MESSAGE)'

# Build the docker images
build:
	$(COMPOSE) -f $(COMPOSE_FILE) build

# Start the containers. -d to start in detached mode to run the containers
# in the background
up:
	$(COMPOSE) -f $(COMPOSE_FILE) up -d

# Remove containers + networks but preserve the volumes
down:
	$(COMPOSE) -f $(COMPOSE_FILE) down

# Stop running the containers without removing them. Think "pause"
stop:
	$(COMPOSE) -f $(COMPOSE_FILE) stop

# Remove containers + networks + volumes
clean:
	$(COMPOSE) -f $(COMPOSE_FILE) down -v

# Clean + remove images relkated to the project
fclean:
	$(COMPOSE) -f $(COMPOSE_FILE) down -v --rmi all --remove-orphans

# fclean then make all
re: fclean all

print_art:
	@echo "       ."
	@echo "      \":\""
	@echo "    ___:____     |\"\\/\"|"
	@echo "  ,'        \`.    \\  /"
	@echo "  |  O        \\___/  |"
	@echo "~^~^~^~^~^~^~^~^~^~^~^~^~"

help:
	@echo "make		→ build images + run containers"
	@echo "make down	→ stop and remove containers"
	@echo "make build	→ build the docker images"
	@echo "make stop	→ stop the containers \(pause\)"
	@echo "make clean	→ remove containers + volumes"
	@echo "make fclean	→ remove containers + volumes + images"
	@echo "make re		→ fclean + all"

.PHONY: all build up down stop clean fclean re print_art help
