#!/usr/bin/env bash 

#Note: on 20140820 Not support 14.04 ref: https://launchpad.net/~cherokee-webserver/+archive/ubuntu/ppa 

sudo add-apt-repository ppa:cherokee-webserver/ppa
sudo apt-get -y update
sudo apt-get -y install cherokee cherokee-admin
echo Ok
