#!/usr/bin/env bash

set -e
echo Install nfs-server
sudo apt-get -y install nfs-common nfs-kernel-server
cnf=/etc/exports
read -p "Vi $cnf to set mountable points"
sudo vi $cnf
cat $cnf
sudo exportfs -a
sudo service nfs-kernel-server restart
echo nfs-server is servicing as \'nfsd\', you can try to mount ...

echo hint: on client machine do as below:
cat <<Doc
* sudo apt-get install nfs-common #portmap
* mkdir /path/to/local/point
* sudo mount -t nfs nfs_server_ip:/path/to/server/mount /path/to/local/point
Doc
