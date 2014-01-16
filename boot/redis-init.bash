#!/usr/bin/env bash 
set -e

prefix=${PREFIX:-/opt/redis}
[ $# -lt 1 ] &&{ 
  echo Usage: $0 version port, default port 6379, available versions: 
  ls -l $prefix
  exit 1
}
version=$1
port=${2:-6379}

_root=$prefix/redis-$version
[ -d $_root/bin ] || { echo No $_root/bin && exit 1;}
[ -e /etc/redis/$port.conf ] && echo Found file /etc/redis/$port.conf && exit 1

echo ==Using redis: $_root/bin/redis-server
cd $_root/utils
tmp_install=install_server_tmp.sh
cp -b install_server.sh $tmp_install
sed -i "s|\( *REDIS_EXECUTABLE=\)\$_REDIS_EXECUTABLE|\1$_root/bin/redis-server|;s/^ *read/# read/g;s/6379/$port/g" $tmp_install
sudo ./$tmp_install
#rm ./$tmp_install

echo Ok, init a redis-server $version instance in port: $port 
