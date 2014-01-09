#!/usr/bin/env bash
set -e
sudo apt-get -y update && sudo apt-get -y upgrade
#easily add repo to apt eg. add-apt-repository ppa:nginx/stable
sudo apt-get -y install python-software-properties 
