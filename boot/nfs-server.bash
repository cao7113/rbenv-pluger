#!/usr/bin/env bash

set -e
echo Install nfs-server, ref: http://shareup.me/server/nfs 
sudo apt-get -y install nfs-kernel-server # nfs-common
cnf=/etc/exports
read -p "Vi $cnf to set mountable points"
sudo vi $cnf
cat $cnf
#sudo exportfs -a
sudo service nfs-kernel-server restart
echo nfs-server is servicing as \'nfsd\', you can try to mount ...

echo hint: on client machine do as below:
cat <<Doc
* sudo apt-get install nfs-common
* mkdir /path/to/local/point
* sudo mount -t nfs nfs_server_ip:/path/to/server/mount /path/to/local/point
* or add into /etc/fstab in syntax:
  example.hostname.com:/ubuntu /local/ubuntu nfs rsize=8192,wsize=8192,timeo=14,intr
* or using autofs(better)
* local vm share/mount point: /vmfs
* view: showmount -e localhost_or_remoteip
Doc
