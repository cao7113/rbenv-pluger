#!/usr/bin/env bash 

<<-Doc
ref https://docs.docker.com/installation/ubuntulinux/

Ubuntu-maintained Package Installation
$ sudo apt-get update
$ sudo apt-get install docker.io

Docker-maintained Package Installation as follows:
Doc

curl -sSL https://get.docker.com/ubuntu/ | sudo sh

<<-Doc
To verify that everything has worked as expected:
$ sudo docker run -i -t ubuntu /bin/bash
Which should download the ubuntu image, and then start bash in a container

For upgrade:
# update your sources list
$ sudo apt-get update

# install the latest
$ sudo apt-get install lxc-docker
Doc

exit 0

#### NOTE: COPIED from above output, run require sudo

# Check that HTTPS transport is available to APT
if [ ! -e /usr/lib/apt/methods/https ]; then
	apt-get update
	apt-get install -y apt-transport-https
fi

# Add the repository to your APT sources
echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list

# Then import the repository key
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9

# Install docker
apt-get update
apt-get install -y lxc-docker

#
# Alternatively, just use the curl-able install.sh script provided at https://get.docker.com
#
