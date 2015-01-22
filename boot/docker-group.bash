#!/usr/bin/env bash 

#set -e

# Add the docker group if it doesn't already exist.
sudo groupadd docker

# Add the connected user "${USER}" to the docker group.
# Change the user name to match your preferred user.
# You may have to logout and log back in again for
# this to take effect.
sudo gpasswd -a ${USER} docker

# Restart the Docker daemon.
# If you are in Ubuntu 14.04, use docker.io instead of docker
#$ sudo service docker restart

sudo restart docker

echo Has add docker group and add $USER into docker group, relog to take effect!
