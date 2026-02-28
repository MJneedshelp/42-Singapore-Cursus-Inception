NAME=inception
START_MESSAGE= $(NAME) is up. "An idea is like a virus"
COMPOSE = docker compose -p $(NAME)
COMPOSE_FILE = srcs/docker-compose.yml
DATA_DIR = /home/mintan/data
DATA_DIR_WORDPRESS = /home/mintan/data/wordpress_files
DATA_DIR_DB = /home/mintan/data/wordpress_db


.DEFAULT_GOAL := all

# Create the data directory if it does not exist
$(DATA_DIR):
	mkdir -p $(DATA_DIR)
	mkdir -p $(DATA_DIR_WORDPRESS)
	mkdir -p $(DATA_DIR_DB)

# Build the images + start containers
all: $(DATA_DIR) build up print_art_alive
	@echo '$(START_MESSAGE)'

# Build the docker images
build:
	$(COMPOSE) -f $(COMPOSE_FILE) build

# Start the containers. -d to start in detached mode to run the containers
# in the background
up:
	$(COMPOSE) -f $(COMPOSE_FILE) up -d

# Remove containers + networks but preserve the volumes
down: print_art_dead
	$(COMPOSE) -f $(COMPOSE_FILE) down

# Stop running the containers without removing them. Think "pause"
stop:
	$(COMPOSE) -f $(COMPOSE_FILE) stop

# Remove containers + networks + volumes
# root-owned files can be left behind by the containers, so we
# escalate when deleting the host data directory to avoid
# "permission denied" errors.
clean:
	$(COMPOSE) -f $(COMPOSE_FILE) down -v
	sudo rm -rf $(DATA_DIR)

# Clean + remove images related to the project
# use sudo when removing the data tree for the same reason as
# the `clean` target above.
fclean:
	$(COMPOSE) -f $(COMPOSE_FILE) down -v --rmi all --remove-orphans
	sudo rm -rf $(DATA_DIR)

# fclean then make all
re: fclean all

print_art_alive:
	@echo "       ."
	@echo "      \":\""
	@echo "    ___:____     |\"\\/\"|"
	@echo "  ,'        \`.    \\  /"
	@echo "  |  O        \\___/  |"
	@echo "~^~^~^~^~^~^~^~^~^~^~^~^~"

print_art_dead:
	@echo "       ."
	@echo "      \":\""
	@echo "    ___:____     |\"\\/\"|"
	@echo "  ,'        \`.    \\  /"
	@echo "  |  X        \\___/  |"
	@echo "~^~^~^~^~^~^~^~^~^~^~^~^~"

help:
	@echo "make		→ build images + run containers"
	@echo "make down	→ stop and remove containers"
	@echo "make build	→ build the docker images"
	@echo "make stop	→ stop the containers \(pause\)"
	@echo "make clean	→ remove containers + volumes"
	@echo "make fclean	→ remove containers + volumes + images"
	@echo "make re		→ fclean + all"

.PHONY: all build up down stop clean fclean re print_art_alive print_art_dead help



## incldue mkdir for data
## remove data when make clean