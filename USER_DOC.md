# Useful Information for Users
## Services provided by the stack
Inception is a **LEMP** stack, which stands for Linux, NGINX, MySQL/MariaDB and PHP. It is a popular web service stack used to host dynamic websites and web applications. Each component of the LEMP stack serves a specific purpose:
- **L - Linux**: The operating system that provides the foundation for the stack. It manages hardware resources and provides a stable environment for the other components to run.
- **E - NGINX (pronounced "engine-x")**: A high-performance web server that serves static content and acts as a reverse proxy for dynamic content. It handles incoming HTTP requests and forwards them to the appropriate backend services, such as PHP-FPM for processing PHP scripts. A reverse proxy is a server that sits in front of one or more backend servers and forwards client requests to those servers. It can provide various benefits such as load balancing, security, and caching. It also provides security features such as SSL/TLS encryption, which can be used to secure the communication between the clients and the server. In this project, NGINX is configured to listen on port 443 for incoming HTTPS requests and forward them to the appropriate backend services based on the request URL.
- **M - MySQL (MariaDB)**: A relational database management system that stores and manages the data for the web applications. In this project, MariaDB is used as the database server to store the data for the WordPress application. It provides a secure and efficient way to manage the data, allowing WordPress to retrieve and store information such as posts, pages, user accounts, and settings.
- **P - PHP**: A server-side scripting language that is used to create dynamic web pages. In this project, PHP is used to process the requests for the WordPress application. It interacts with the MariaDB database to retrieve and store data, and it generates the HTML content that is sent back to the clients through NGINX. The PHP-FPM (FastCGI Process Manager) is used to manage the PHP processes and improve the performance of the application.
- **WordPress**: A popular content management system (CMS) that allows users to create and manage websites easily. It is built on top of PHP and uses a MariaDB database to store content and settings. In this project, WordPress is used as the application layer of the stack, allowing users to create and manage their website content through a user-friendly interface. It connects to the MariaDB database to store and retrieve data, and it relies on NGINX to serve the web pages to the clients.

## Docker in a nutshell
- **Dockerfile**: A text file that contains instructions for building a Docker image. It defines the base image, the commands to run, and the files to copy into the image.
- **Docker image**: A lightweight, standalone, and executable package that includes everything needed to run a piece of software, including the code, runtime, libraries, and dependencies. It is created from a Dockerfile and can be shared and distributed.
- **Docker container**: A running instance of a Docker image. It is an isolated environment that runs on the host machine and shares the host's operating system kernel. Each container has its own filesystem, network, and process space, allowing it to run independently from other containers and the host system.
- **General process**: Dockerfile (_build_) -> Docker image (_run_) -> Docker container

## Starting and stopping the project
1. Navigate to the project directory
1. Run ```make help``` to see the available commands and take it from there

| Command | Description |
| --- | --- |
| make all | build images + run containers |
| make down | stop and remove containers |
| make build | build the docker images |
| make stop | stop containers (pause) |
| make clean | remove containers + volumes |
| make fclean | remove containers + volumes + images |
| make re | fclean + all |
| make ps | check the status of the containers for this project |

## Accessing the website and the administration panel
1. **Website**: https://localhost or https://mintan.42singapore.sg
	- It is normal to see a warning about a potential security risk when you access the website.
	- The TLS certificate used in this project is self-signed, which means that it is not issued by a trusted certificate authority (CA)
	- Click **Advanced** -> **Accept the Risk and Continue** to access the website
2. **Admin panel**: https://localhost/wp-admin or https://mintan.42singapore.sg/wp-admin

## Configuring your Credentials
1. Open the /srcs/.env file and update the following variables before the first run:
	- **WP_ADMIN_USER**: WordPress admin username. This is the account that you will use to log in to the WordPress admin panel
	- **WP_ADMIN_EMAIL**: WordPress admin email
	- **MYSQL_USER**: DB admin username. This is the account that WordPress will use to connect to the database.
2.  Adjust the credentials in the secret files /home/mintan/Documents/secrets or update the secret file paths in the docker-compose.yml file to point to the correct location of the secret files:
	- **wp_admin_password.txt**: WordPress admin password
	- **db_password.txt**: DB admin password
	- **db_root_password.txt**: DB root password. This is the password used by the root user to access the database

## Checking that the services are running correctly
1. Run ```make ps``` to check the status of the containers for this project. You should see that all the containers are up and running
2. If you're using vs code, I find the **Container Tools** extension to be very helpful in visualising the containers, the images and the networks
3. You can also check the logs for each container using the command ```docker logs {container_name}``` to see if there are any errors or issues with the services

## Other useful commands (imo)
The commands are already subsumed in the Makefile. You can use these if you want to control the containers individually.
1. docker build: Used to build a Docker image from a Dockerfile.
1. docker run: Used to run a Docker container based on a Docker image.
1. docker ps: Used to list the running Docker containers on a system.
1. docker stop: Used to stop a running Docker container.
1. docker rm: Used to remove a Docker container.
1. docker rmi: Used to remove a Docker image.
1. docker exec: Used to execute a command in a running Docker container. Especially useful for debugging inside the container. ```docker exec -it {container_name} bash``` to get a bash shell inside the container (this was really useful hahaha)
1. docker logs: Used to view the logs for a Docker container. Especially useful for debugging (print the steps in your shell scripts!)