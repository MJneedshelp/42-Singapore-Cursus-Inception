*This project has been created as part of the 42 curriculum by mintan*

## Description
This project aims to broaden our knowledge of system administration by using Docker to to set up a small 
infrastructure composed of different services.

### What is Docker?
It is an open platform for developing, shipping and running applications. It provides the ability to 
package an application and everything it neeeds to run - code, libraries and dependencies etc. into a lightweight 
a loosely isolated environment called a container.

### Virtual Machines vs Docker

#### Virtual Machines (VM)
A VM is like a computer within the computer - it runs its own operating system within the computer. A VM emulates
hardware; it includes virtual CPU, virtual memory and a guest OS. I.e. everything that a computer has, a VM will
have as well.

#### Docker
A container is a form of OS-level virtualisation. Rather than emulating the entire machine, it shares the host OS kernel and isolates the application processes from the rest of the system. The container runs as a process on the host with isolation mechanisms provided by the OS. It is more lightweight than a VM, as it does not require a full guest OS to run.

![VM vs Docker](/images/Docker-vs-VM.png)

| Factors | Virtual Machines | Docker Containers |
|--------:|-----------------:|------------------:|
| **Boot Time** | Minutes | Seconds |
| **Availability** | Ready-made VMs are not widely available | Pre-built containers can be found in various registries |
| **Resource Usage** | High, as each VM requires its own OS | Low, as containers share the host OS kernel |
| **Storage** | Might be a few GBs to tens of GBs | Typically a few MBs to a few hundred MBs |
| **Operating System** | Each VM can run a different OS | All containers share the same OS kernel |
| **Use Cases** | Suitable for running multiple different OSes on the same hardware, or for applications that require strong isolation | Ideal for microservices, application deployment, and environments where resource efficiency is important |

### Secrets vs Environment Variables
- **Environment Variables**: These are key-value pairs that are set in the environment of a process. They are commonly used to configure applications, but they are not secure for storing sensitive information, as they can be easily accessed by anyone with access to the environment. For example, if you set an environment variable for a database password, it can be exposed in logs, process lists, or through debugging tools.
- **Secrets**: Sensitive information that should be stored securely and accessed only by authorized applications or users. In this project, services can only access secrets when explicitly granted by a ```secrets``` attribute within the service definition in the docker-compose.yml file.

### Docker Networks vs Host Network
- **Docker Networks**: Docker provides a default bridge network for containers to communicate with each other. You can also create custom networks to isolate groups of containers. When using Docker networks, containers can communicate with each other using their service names as hostnames, and they are isolated from the host network. This project uses a custom network - oneiro_web - to allow the services to communicate with each other while keeping them isolated from the host network.
- **Host Network**: When a container is run with the host network mode, it shares the host's network stack. This means that the container can access the host's network interfaces directly, and it can use the same IP address as the host. This can be useful for certain applications that require low latency or need to access specific network resources on the host, but it also means that the container is not isolated from the host network, which can pose security risks.

### Docker Volumes vs Bind Mounts
- **Docker Volumes**: These are managed by Docker and are stored in a part of the host filesystem that is managed by Docker (e.g., /var/lib/docker/volumes/). Volumes are designed to persist data and can be easily shared between containers. They are also more portable, as they can be easily backed up and moved to different hosts.
- **Bind Mounts**: These allow you to mount a file or directory from the host filesystem into a container. The file or directory on the host is directly accessible to the container, and any changes made to it will be reflected in the container. Changes made in the container will also affect the host. Bind mounts are useful for development purposes, as they allow you to edit files on the host and see the changes in the container immediately. However, they can be less portable and may have security implications if not used carefully.

## Instructions
### Prerequisites for running this project
1. Get Docker installed: https://docs.docker.com/engine/install/debian/
1. Get Make intalled: run ```sudo apt-get install build-essential```
1. Create the following directory: ```/home/{your login}/data/```

### How to run the project
1. Clone the repository: ```git clone```
1. Navigate to the project directory
1. Run ```make help``` to see the available commands and take it from there

## Resources
1. Good for getting a general understanding of Docker:
    - https://docs.docker.com/get-started/docker-overview/
    - https://www.reddit.com/r/docker/comments/keq9el/please_someone_explain_docker_to_me_like_i_am_an/
1. Virtual Machines vs Docker:
    - https://www.geeksforgeeks.org/devops/docker-or-virtual-machines-which-is-a-better-choice/
1. Secrets vs Environment Variables:
    - https://docs.docker.com/compose/how-tos/use-secrets/
1. Docker Networks vs Host Network:
    - https://docs.docker.com/engine/network
1. Docker Volumes vs Bind Mounts:
    - https://docs.docker.com/engine/storage/volumes/
    - https://docs.docker.com/reference/compose-file/volumes/
1. What is an LEMP stack:
    - https://www.geeksforgeeks.org/websites-apps/what-is-lemp-stack/
1. Choosing between CMD and ENTRYPOINT in Dockerfile:
    - https://www.docker.com/blog/docker-best-practices-choosing-between-run-cmd-and-entrypoint/
1. Installing wp-cli:
    - https://wp-cli.org/#installing
