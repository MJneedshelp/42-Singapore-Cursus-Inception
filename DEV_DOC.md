DEV_DOC.md — Developer documentation This file must describe how a developer can:
◦ Set up the environment from scratch (prerequisites, configuration files, secrets).
◦ Build and launch the project using the Makefile and Docker Compose.
◦ Use relevant commands to manage the containers and volumes.
◦ Identify where the project data is stored and how it persists.

# Useful Information for Developers


## Set up the environment from scratch (prerequisites, configuration files, secrets)
In general, each of the containers will have a Dockerfile that defines how to build the image for that container, and a shell script that is executed when the container is run. The last line of the shell script is usually the command to start the main service for that container (e.g., NGINX, php-fpm, MariaDB) as PID 1. Services where the information is required is complete, are usually downloaded during build time within the Dockerfile. Services that require information that is only available during runtime (e.g., database credentials) are downloaded during runtime within the shell script. This is because the Dockerfile is executed during build time, while the shell script is executed during runtime when the container is run. The Dockerfile is used to set up the environment for the container, including installing necessary packages and dependencies, while the shell script is used to configure the services and start them when the container is run.

### NGINX
1. NGINX is a web server that is used as a reverse proxy in this project. A reverse proxy is a server that sits in front of one or more backend servers and forwards client requests to those servers.
2. Workflow (general): Client -> NGINX (port 443) -> Wordpress (port 9000), processed by php-fpm -> NGINX -> Client:
	1. Client sends a request to NGINX via port 443 (e.g., https://localhost:443). This is done via TLS v1.3 or TLS v1.2, which means that the communication between the client and NGINX is encrypted. Requests that are not using HTTPS are redirected to HTTPS.
	2. To use TLS, a TLS certificate is required. In this project, a self-signed TLS certificate is generated using OpenSSL via the **setup.sh** script when the container is run.
	3. When a request is received, NGINX decrypts the request and forwards it to the Wordpress container via port 9000 through the docker network.
	4. The Wordpress container contains a php-fpm service that listens for requests on port 9000. When it receives the request from NGINX, it processes the request and generates a response.
	5. The response is sent back to NGINX, which then encrypts the response and sends it back to the client via port 443.
3. Configuration files and scripts:
	- nginx.conf: the main configuration file for NGINX. It includes the configuration for the server, which listens on port 443 and forwards requests to the Wordpress container on port 9000. It also includes the configuration for TLS, specifying the location of the TLS certificate and private key.
	- setup.sh: a shell script that is executed when the NGINX container is run. It generates a self-signed TLS certificate using OpenSSL and saves it to the appropriate location for NGINX to use.

**Note**: 
1. Transport Layer Security (TLS) is a cryptographic protocol that provides secure communication over a computer network. It is the successor to Secure Sockets Layer (SSL) and is widely used to secure web traffic. HTTPS (Hypertext Transfer Protocol Secure) is the secure version of HTTP, which uses TLS to encrypt the communication between the client and the server. When a client makes a request to an HTTPS URL, the communication is encrypted using TLS, ensuring that the data transmitted between the client and the server is secure and cannot be intercepted by attackers. 
2. A TLS certificate is used to prove "I am who I say I am". In normal circumstances, a TLS certificate is issued by a trusted certificate authority (CA) and is used to establish a secure connection between a client and a server. The certificate contains information about the identity of the server, as well as the public key that is used for encryption. When a client connects to a server using HTTPS, the server presents its TLS certificate to the client. The client then verifies the certificate against a list of trusted CAs to ensure that it is valid and that the server can be trusted. If the certificate is valid, the client and server can establish a secure connection using TLS. In this project, a self-signed TLS certificate is generated using OpenSSL. A self-signed certificate is a TLS certificate that is signed by the same entity that created it, rather than by a trusted certificate authority (CA). Self-signed certificates can be used for testing and development purposes, but they are not trusted by clients by default, as they do not have a trusted CA to verify their authenticity. When a client connects to a server using a self-signed certificate, the client will typically display a warning message indicating that the certificate is not trusted. 
3. NGINX sends the request to php-fpm using the FastCGI protocol. FastCGI is a protocol for interfacing interactive programs with a web server. It is an extension of the Common Gateway Interface (CGI) that provides better performance by keeping the application processes running and reusing them for multiple requests, rather than starting a new process for each request as in CGI. In this project, NGINX is configured to use FastCGI to communicate with the php-fpm service in the Wordpress container. When a request for a PHP file is received, NGINX forwards the request to php-fpm using FastCGI, which processes the request and generates a response that is sent back to NGINX.

### WordPress
1. WordPress is a content management system (CMS) that is used to create and manage websites. In this project, it is used as the backend server that generates the responses to the client requests.
2. Configuration files and scripts:
	- start.sh: a shell script that is executed when the WordPress container is run. It downloads the the latest version of WordPress and creates the wp-config.php file using the environment variables and secrets provided in the docker-compose.yml file. It also downloads WordPress core files and sets it up with the admin credentials provided in the secrets. Finally, it starts the php-fpm service to listen for requests from NGINX.
	- wp-config.php: the configuration file for WordPress. It contains the database connection details, including the database host, username, password, and database name. In this project, these details are provided via environment variables that are set in the docker-compose.yml file.

### MariaDB
1. MariaDB is a relational database management system (RDBMS) that is used to store the data for the WordPress site. It is a fork of MySQL and is compatible with MySQL.
2. Configuration files and scripts:
	- init.sh: a shell script that is executed when the MariaDB container is run. It installs the MariaDB database and starts the MariaDB server. On the first run, it initializes the database by creating a new database and a new user with the credentials provided in the secrets. It also grants the necessary permissions to the user to access the database. This is done by starting a temporary MariaDB server with networking disabled, which allows us to execute SQL commands to set up the database and user without exposing the server to external connections. After setting up the database and user using the init.sql script, it stops the temporary server and starts the main MariaDB server to listen for requests from WordPress.
	- init.sql: a SQL script that is used to initialize the database on the first run. It creates a new database and a new user with the credentials provided in the secrets, and grants the necessary permissions to the user to access the database.

## Using the Makefile and Docker Compose
- **Makefile**: provides a convenient way to manage the Docker containers and images for this project. It includes commands to build the images, run the containers, stop the containers, and clean up the resources. The Makefile abstracts away the underlying Docker commands, making it easier for developers to manage the project without needing to remember the specific Docker commands.
- **Docker Compose**: is a tool that allows you to define and manage multi-container Docker applications. It uses a YAML file (docker-compose.yml) to configure the services, networks, and volumes for the application. In this project, Docker Compose is used to orchestrate the NGINX, WordPress, and MariaDB containers, allowing them to communicate with each other and share resources as needed. The docker-compose.yml file defines the configuration for each service, including the image to use, the ports to expose, the environment variables, the volumes to mount, and the secrets to use.
- **make help**: see the available commands

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

- **Other useful commands**: These commands are already subsumed in the Makefile. You can use these if you want to control the containers individually.

These commands are already subsumed in the Makefile. You can use these if you want to control the containers individually.
1. docker build: Used to build a Docker image from a Dockerfile.
1. docker run: Used to run a Docker container based on a Docker image.
1. docker ps: Used to list the running Docker containers on a system.
1. docker stop: Used to stop a running Docker container.
1. docker rm: Used to remove a Docker container.
1. docker rmi: Used to remove a Docker image.
1. docker exec: Used to execute a command in a running Docker container. Especially useful for debugging inside the container. ```docker exec -it {container_name} bash``` to get a bash shell inside the container (this was really useful hahaha)
1. docker logs: Used to view the logs for a Docker container. Especially useful for debugging (print the steps in your shell scripts!)

## Project data storage and persistence
1. "Both named volumes must store their data inside /home/login/data on the host machine." according to the subject
2. docker-compose.yml file | volumes section | volume location on host machine:
	- wordpress files: /home/${USER}/data/wordpress_files
	- mariadb files: /home/${USER}/data/wordpress_db
2. location of the data in the containers: 
	- wordpress container volume: /var/www/html
	- mariadb container volume: /var/lib/mysql
3. Since the data is stored in volumes that are mounted to the host machine, the data persists even if the containers are stopped or removed. When the containers are run again, they will use the same volumes, and the data will be available as it was before.
4. To remove the data in the volumes, use ```make clean``` to remove the containers and volumes























PID 1
- each container only has 1 process tree
- usually you'll want to run a long running service like NGINX or php-fpm as PID 1