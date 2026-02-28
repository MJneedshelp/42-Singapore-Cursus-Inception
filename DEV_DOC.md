DEV_DOC.md — Developer documentation This file must describe how a developer can:
◦ Set up the environment from scratch (prerequisites, configuration files, secrets).
◦ Build and launch the project using the Makefile and Docker Compose.
◦ Use relevant commands to manage the containers and volumes.
◦ Identify where the project data is stored and how it persists.




















- dockerfile (build)-> docker image (run)-> docker container
- dockerfile -> use to build a docker image. Like instructions to build the the docker image
- docker image -> becomes a container when the image is run. Is a running instance of the image. Runs as an - isolated process on the host machine but shares the host's operating system kernel
- docker container -> running instance of the docker image



PID 1
- each container only has 1 process tree
- usually you'll want to run a long running service like NGINX or php-fpm as PID 1





Source:
- https://www.docker.com/blog/docker-best-practices-choosing-between-run-cmd-and-entrypoint/
- Installing wp-cli: https://wp-cli.org/#installing
- Volumes vs bind mounts: https://docs.docker.com/reference/compose-file/volumes/


