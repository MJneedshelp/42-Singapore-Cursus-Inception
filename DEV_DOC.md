- dockerfile (build)-> docker image (run)-> docker container
- dockerfile -> use to build a docker image. Like instructions to build the the docker image
- docker image -> becomes a container when the image is run. Is a running instance of the image. Runs as an - isolated process on the host machine but shares the host's operating system kernel
- docker container -> running instance of the docker image



PID 1
- each container only has 1 process tree
- usually you'll want to run a long running service like NGINX or php-fpm as PID 1







