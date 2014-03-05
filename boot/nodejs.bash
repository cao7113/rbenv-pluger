#!/usr/bin/env bash
set -e
#https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager
#sudo add-apt-repository ppa:chris-lea/node.js && sudo apt-get -y update && sudo apt-get -y install nodejs

#sudo apt-get -y install nodejs

#Try latest nodejs and npm cli 

echo Ref: https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager
#sudo apt-get update
sudo apt-get install -y python-software-properties python g++ make
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install nodejs

echo It installs current stable Node on the current stable Ubuntu. 12.10 and 13.04 users may need to install the software-properties-common package for the add-apt-repository command to work: sudo apt-get install software-properties-common
