#!/usr/bin/env bash

#dedicated user: nginx

set -e
! which nginx &>/dev/null || { echo Has installed nginx && exit 1;}

echo latest at http://nginx.org/en/download.html

sudo apt-get -y update
sudo apt-get -y install nginx
echo installed nginx `nginx -V` ...
