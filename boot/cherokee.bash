#!/usr/bin/env bash 

sudo add-apt-repository ppa:cherokee-webserver/ppa
sudo apt-get -y update
sudo apt-get -y install cherokee cherokee-admin
echo Ok
