#!/usr/bin/env bash

#dedicated user: nginx

set -e
! which nginx &>/dev/null || exit 1

echo latest at http://nginx.org/en/download.html
echo http://nginx.org/en/linux_packages.html#stable
nginx_sources_list=/etc/apt/sources.list.d/nginx-stable.list
[ -f $nginx_sources_list ] && echo Found $nginx_sources_list && exit 1 

wget -O /tmp/nginx_signing.key http://nginx.org/keys/nginx_signing.key
sudo apt-key add /tmp/nginx_signing.key

ubuntu_codename=`lsb_release --codename --short` #e.g. precise for ubuntu 12.04LTS
sudo cat<<-Note >$nginx_sources_list
#set nginx sources
deb http://nginx.org/packages/ubuntu/ $ubuntu_codename nginx
deb-src http://nginx.org/packages/ubuntu/ $ubuntu_codename nginx
Note

sudo apt-get -y update
sudo apt-get -y install nginx
echo installed nginx `nginx -V` ...
