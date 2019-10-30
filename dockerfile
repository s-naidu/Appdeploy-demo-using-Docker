# Download base image ubuntu 18.04
FROM ubuntu:18.04

LABEL MAINTAINER=<sudarshan.naidu@sts.in>

#SHELL ["/bin/bash", "-c"]

# Update Ubuntu Software repository
RUN apt-get update

# Install all required packages
RUN apt-get install -y --no-install-recommends \
    python3.6 \
    python3-pip \
    python3-venv \
    python3-distutils \
    python3-setuptools \
    python3-dev \
    libmysqlclient-dev \
    build-essential

# RUN apt-get install -y git

# Upgrade packages
RUN python3.6 -m pip install --upgrade \
    pip \
    setuptools

# Set environment variable
ENV APP_PATH=/usr/src/app VIRTUAL_ENV=pyenv LC_ALL=C.UTF-8 LANG=C.UTF-8
ENV PYTHONUSERBASE=$APP_PATH/${VIRTUAL_ENV} PATH=$APP_PATH/${VIRTUAL_ENV}/bin:$PATH
ENV GOOGLE_APPLICATION_CREDENTIALS='test.json'

# Set the working directory using WORKDIR.
WORKDIR $APP_PATH

# Copy files using the COPY command
COPY . .

# List current dir items
RUN ls

# Create virtual environment for pyhton
RUN echo "PWD is: $PWD" && \
    python3.6 --version && \
    python3.6 -m venv $VIRTUAL_ENV


# Expose port from docker to map to host machine port using docker run
EXPOSE 5000

# List current dir items
RUN echo $VIRTUAL_ENV

# Commands to execute on docker run
CMD [ 'read -p "$*"' ]
