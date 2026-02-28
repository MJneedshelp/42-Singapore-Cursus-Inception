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

## Instructions





## Resources
1. Good for getting a general understanding of Docker:
    - https://docs.docker.com/get-started/docker-overview/
    - https://www.reddit.com/r/docker/comments/keq9el/please_someone_explain_docker_to_me_like_i_am_an/
1. Virtual Machines vs Docker
    - https://www.geeksforgeeks.org/devops/docker-or-virtual-machines-which-is-a-better-choice/