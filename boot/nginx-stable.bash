#!/usr/bin/env bash

#dedicated user: nginx

set -e
! which nginx &>/dev/null || exit 1

echo latest at http://nginx.org/en/download.html
echo http://nginx.org/en/linux_packages.html#stable
sources_file=/etc/apt/sources.list
grep -q nginx $sources_file && echo Installed nginx && exit 1 

wget -O /tmp/nginx_signing.key http://nginx.org/keys/nginx_signing.key
sudo apt-key add /etc/nginx_signing.key

ubuntu_codename=`lsb_release --codename --short` #e.g. precise for ubuntu 12.04LTS
#TODO permission! into /etc/apt/sources.list.d?
sudo cat<<-Note >>/etc/apt/sources.list
#set nginx sources
deb http://nginx.org/packages/ubuntu/ $ubuntu_codename nginx
deb-src http://nginx.org/packages/ubuntu/ $ubuntu_codename nginx
Note

sudo apt-get -y update
sudo apt-get -y install nginx
echo installed nginx `nginx -V` ...
