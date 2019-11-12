# Introduction to the Docker

Docker is operating-system-level virtualization mainly intended for developers and sysadmins. Docker makes it easier to create and deploy applications in an isolated environment. 
 Dockerfile is a script that contains collections of commands and instructions that will be automatically executed in sequence in the docker environment for building a new docker image.
In this tutorial, I will show you how to create your own docker image with a dockerfile. I will explain the dockerfile script in detail to enable you to build your own dockerfile scripts.
Prerequisite
Ubuntu 16.04 as the host machine and docker base image.
Root Privileges.
Introduction to the Dockerfile Command
A dockerfile is a script that contains a collection of dockerfile commands and operating system commands (ex: Linux commands). Before we create our first dockerfile, you should become familiar with the dockerfile command.
 
  
# Below are some dockerfile commands you must know:
```
FROM: The base image for building a new image. This command must be on top of the dockerfile.
RUN : Used to execute a command during the build process of the docker image.
ADD : Copy a file from the host machine to the new docker image. There is an option to use a URL for the file, docker will then download that file to the destination directory.
ENV : Define an environment variable.
CMD: Used for executing commands when we build a new container from the docker image.
ENTRYPOINT : Define the default command that will be executed when the container is running.
WORKDIR: This is directive for CMD command to be executed.
USER: Set the user or UID for the container created with the image.
VOLUME: Enable access/linked directory between the container and the host machine.
EXPOSE:Informs Docker that the container listens on the specified network port(s) at runtime.
EXPOSE does not make the ports of the container accessible to the host.
```
```
 Now let's start to create our first dockerfile.
 ```
 ```
 Step 1 - Installing Docker
```
 Login to your server and update the software repository. (use Putty tool)
 
 Sudo apt-get update

 Install docker.io with this apt command:
apt-get install docker.io

 When the installation is finished, start the docker service and enable it to start at boot time:

systemctl start docker
systemctl enable docker

Docker has been installed and is running on the system.
 
 Step 2 - Create Dockerfile

In this step, we will create a new directory for the dockerfile and define what we want to do with that dockerfile.
Create a new directory and a new and empty dockerfile inside that directory.
```
mkdir ~/deploy-demo
cd deploy-demo/
touch index.html
Edit index.html
Nano index.html add some content then save and exit
```
 
Edit the 'Dockerfile' with nano:

touch Dockerfile

nano Dockerfile

Here is the complete Dockerfile in one piece:
```
#Download base image ubuntu 16.04
FROM ubuntu
RUN apt-get update
RUN apt-get install nginx -y
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
COPY index.html /var/www/html/
EXPOSE 80
CMD ["nginx","-g","daemon off;"]								
```
 Step 3 - Build New Docker Image and Create New Container Based on it

The Dockerfile and all required config files have been created, now we can build a new docker image based on Ubuntu 16.04 and our dockerfile with the docker command below:
docker build -t nginx_image .

 When the command completed successfully, we can check the new image 'nginx_image' with the docker command below:

docker images

 Now run the new container with the command below:

docker run -d -p884:80 -- my_test
Then we can check that the new container with name my_test based on 'nginx_image' is running:
docker ps

Note:
--name my_test nginx_image = We create a new container with the name my_test, based on docker image 'nginx_images'.
-p 884:80 = my_test container running on port 80 on the host machine.
The new container based on the nginx_image is running without error.

