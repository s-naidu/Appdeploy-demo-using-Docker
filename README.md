Example Index html page

Getting started
Login to server
Install docker
Download Docker On UBUNTU

How to Build Docker Images with Dockerfile

A Docker image is the blueprint of Docker containers that contains the application and everything you need to run the application. A container is a runtime instance of an image.

In this tutorial, we will explain what Dockerfile is, how to create one, and how to build a Docker image with Dockerfile.

What is Dockerfile

A Dockerfile is a text file that contains all the commands a user could run on the command line to create an image. It includes all the instructions needed by Docker to build the image.

Docker images are made up of a series of filesystem layers representing instructions in the image’s Dockerfile that makes up an executable software application.

The Docker file takes the following form:

# Comment
INSTRUCTION arguments
Copy
INSTRUCTION is not case-sensitive, but the convention is to use UPPERCASE for its names.

Create a Dockerfile

The most common scenario when creating Docker images is to pull an existing image from a registry (usually from Docker Hub) and specify the changes you want to make on the base image. The most commonly used base image when creating Docker images is Alpine because it is small and optimized to be run in RAM.

The Docker Hub is cloud-based registry service which among other functionalities is used for keeping the Docker images either in a public or private repository.
In this example, we will create a Docker image for the Redis server. We’ll use the latest ubuntu 18.04 as a base image.

First, create a directory that will contain the Dockerfile and all the necessary files:

mkdir ~/redis_docker
Copy
Navigate to the directory and create the following Dockerfile:

cd ~/redis_docker
nano Dockerfile
Copy
Dockerfile

Create Dockerfile with following content

FROM ubuntu
RUN apt-get update
RUN apt-get install nginx -y
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
COPY index.html /var/www/html/
EXPOSE 80
CMD ["nginx","-g","daemon off;"]

Building the Image

The next step is to build the image. To do so run the following command from the directory where the Dockerfile is located:

docker build -t sample .

output will be displayed as follows

 ---> Running in a5666f87a68a
Removing intermediate container a5666f87a68a
 ---> e26263ec9c59
Step 7/7 : CMD ["nginx","-g","daemon off;"]
 ---> Running in 0f4086bcb0fc
Removing intermediate container 0f4086bcb0fc
 ---> 2f6533727dcd
Successfully built 2f6533727dcd
Successfully tagged my_demo:latest

administrator@micro-quickstart:~$ docker run -d -p 8088:80 my_demo
6215222f313860bd16cf9be9b6b4999a8df9939ec6d2ca111aa574dc9dc8e857


docker run -d -p884:80 --my_demo

The -d options tell Docker to run the container in detached mode, the -p 6379:6379 option will publish the port 6379 to the host machine and the --name redis option specifies the container name. The last argument linuxize/redis is the name of the image, which is used to run the container.

When the container starts, use the following command to list all running containers:

docker container ls
administrator@micro-quickstart:~$ docker container ls
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                  NAMES
6215222f3138        my_demo             "nginx -g 'daemon of…"   30 minutes ago      Up 30 minutes       0.0.0.0:8088->80/tcp   nervous_mayer

To verify that everything works as it should use the host ip to connect to the docker container:
