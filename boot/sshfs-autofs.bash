#!/usr/bin/env bash 
#Created from mksh on 2014年 08月 19日 星期二 14:47:36 CST

#在vagrant上 运行ssh+autofs 访问host机器的资源
#terms:
# * client: vagrant vm1
# * target: host 

host_user=${1:-cao}
host_ip=${2:-10.0.2.2}
host_point=${3} #default home dir
target_user=$USER
target_uid=$(id -u)
target_gid=$(id -g)
ssh_key=/home/$target_user/.ssh/id_rsa

###在vagrant上运行：

sudo apt-get -y install sshfs autofs
[ ! -d /host ] && sudo mkdir /host
#echo add current user into fuse group by: sudo usermod -a -G fuse vagrant

if [ ! -f "$ssh_key" ];then
  echo generate ssh keys
  ssh-keygen
fi
ssh-copy-id -i ${ssh_key}.pub $host_user@$host_ip  #ssh-copy-id -i .ssh/id_rsa.pub cao@10.0.2.2
ssh $host_user@$host_ip #to accept host???

tmp_master=/tmp/auto.${host_user}.autofs
cat <<-Config >$tmp_master
/host /etc/auto.sshfs uid=$target_uid,gid=$target_gid,--timeout=120,--ghost
Config
if [ ! -d /etc/auto.master.d ];then
  sudo mkdir -p /etc/auto.master.d
  sudo mv -b $tmp_master /etc/auto.master.d
fi

cat <<-Config >/tmp/auto.sshfs
$host_user -fstype=fuse,rw,nodev,nonempty,noatime,allow_other,reconnect,IdentityFile=$ssh_key,uid=$target_uid,gid=$target_gid,max_read=65536,compression=yes,auto_cache,no_check_root,kernel_cache :sshfs\#$host_user@$host_ip\:
Config
sudo mv -b /tmp/auto.sshfs /etc/auto.sshfs

cat <<-Note
  run autofs by: sudo restart autofs 
  access /host/$host_user for $host_ip files
  check current mount points by: mount
  removte mount point by: umount
  debug: sudo automount --debug -f /etc/auto.master
Note
