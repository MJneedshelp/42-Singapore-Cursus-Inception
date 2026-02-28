NAME=inception
START_MESSAGE= $(NAME) is up. "An idea is like a virus"
COMPOSE = docker compose -p $(NAME) -f $(COMPOSE_FILE)
COMPOSE_FILE = srcs/docker-compose.yml
DATA_DIR = /home/$(USER)/data
DATA_DIR_WORDPRESS = /home/$(USER)/data/wordpress_files
DATA_DIR_DB = /home/$(USER)/data/wordpress_db


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
	$(COMPOSE) build

# Start the containers. -d to start in detached mode to run the containers
# in the background
up:
	$(COMPOSE) up -d

# Remove containers + networks but preserve the volumes
down: print_art_dead
	$(COMPOSE) down

# Stop running the containers without removing them. Think "pause"
stop:
	$(COMPOSE) stop

# Remove containers + networks + volumes
clean:
	$(COMPOSE) down -v
	sudo rm -rf $(DATA_DIR)

# Clean + remove images related to the project
fclean:
	$(COMPOSE) down -v --rmi all --remove-orphans
	sudo rm -rf $(DATA_DIR)

# fclean then make all
re: fclean all

# Docker Compose Process Status
ps: print_art_ps
	$(COMPOSE) ps

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

print_art_ps:
	@echo "            ~     ~"
	@echo "       .        ~"
	@echo "      \":\""
	@echo "    ___:____     |\"\\/\"|    ~"
	@echo "  ,'        \`.    \\  /"
	@echo "  |  O        \\___/  |~~~"
	@echo "   \\   ~~~            /"
	@echo "    \\      ~~~        /"
	@echo "     \`-._________.-\'"
	@echo "        ~  ~  ~   ~"
	@echo "~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~"

help:
	@echo "make		→ build images + run containers"
	@echo "make down	→ stop and remove containers"
	@echo "make build	→ build the docker images"
	@echo "make stop	→ stop the containers (pause)"
	@echo "make clean	→ remove containers + volumes"
	@echo "make fclean	→ remove containers + volumes + images"
	@echo "make re		→ fclean + all"
	@echo "make ps		→ check the status of the containers for this project"

.PHONY: all build up down stop clean fclean re print_art_alive print_art_dead help



## incldue mkdir for data
## remove data when make clean