#!/usr/bin/env bash 
set -e

prefix=${PREFIX:-/opt/redis}
[ $# -lt 1 ] &&{ 
  echo Usage: $0 version, available versions: 
  ls -l $prefix
  exit 1
}
version=$1

_root=$prefix/redis-$version
[ -d $_root/bin ] || { echo No $_root/bin && exit 1;}

echo ==Using redis: $_root/bin/redis-server
cd $_root/utils
cp install_server.sh install_server_local.sh
sed -i 
#sudo ./install_server.sh

link=/usr/local/bin/redis-$version-cli
target_cli=$_root/bin/redis-cli
if [ -e $link ];then
  echo Warn: found an existed link $link
else
  echo "Make a handy link: $link -->$target_cli "
  sudo ln -s $target_cli $link
fi
