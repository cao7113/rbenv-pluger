#!/usr/bin/env bash 
#Created from mksh on 2014年 08月 19日 星期二 14:47:36 CST

#Usage:
#在vm上可以访问host机器上的文件系统
#host: master user's home dir, ~
#hostroot: host's root path, / 

#在vagrant上 运行ssh+autofs 访问host机器的资源
#terms:
# * client: vagrant vm1
# * target: host machine 

set -e 
host_user=${1:-cao}
host_ip=${2:-10.0.2.2}
host_point=${3} #default home dir
target_user=$USER
target_uid=$(id -u)
target_gid=$(id -g)
ssh_key=/home/$target_user/.ssh/id_rsa

sudo apt-get -y install sshfs autofs

#Not need!!!
#echo add current user into fuse group by: sudo usermod -a -G fuse vagrant

if [ ! -f "$ssh_key" ];then
  echo generating ssh keys
  ssh-keygen -t rsa -f ~/.ssh/id_rsa -N '' -C 'vagrant vm'
fi
ssh-copy-id -i ${ssh_key}.pub $host_user@$host_ip  #copy pub key into host
#ensure The authenticity of host '10.0.2.2 (10.0.2.2)' for root user, add an item in /root/.ssh/known_hosts
sudo ssh -o StrictHostKeyChecking=no -i $ssh_key $host_user@$host_ip ':' #not login

tmp_master=/tmp/host.sshfs.autofs #require *.autofs config file
cat <<-Config >$tmp_master
#--verbose 
#use direct map, ref: https://help.ubuntu.com/community/Autofs
/- /etc/auto.sshfs uid=$target_uid,gid=$target_gid,--timeout=120,--ghost
Config
sudo mkdir -p /etc/auto.master.d
sudo mv -b $tmp_master /etc/auto.master.d

tmp_map=/tmp/auto.sshfs
cat <<-Config >/tmp/auto.sshfs
/host -fstype=fuse,rw,nodev,nonempty,noatime,allow_other,reconnect,IdentityFile=$ssh_key,uid=$target_uid,gid=$target_gid,max_read=65536,compression=yes,auto_cache,no_check_root,kernel_cache :sshfs\#$host_user@$host_ip\:
/hostroot -fstype=fuse,rw,nodev,nonempty,noatime,allow_other,reconnect,IdentityFile=$ssh_key,uid=$target_uid,gid=$target_gid,max_read=65536,compression=yes,auto_cache,no_check_root,kernel_cache :sshfs\#$host_user@$host_ip\:/
Config
sudo mv -b $tmp_map /etc
sudo restart autofs

cat <<-Note
  ok, config file: /etc/$(basename $tmp_map)
  access /host or /hostroot for $host_ip files
  check current mount points by: mount
  removte mount point by: umount
Note

exit 0


解决问题：

debug模式运行： sudo automount --debug -f /etc/auto.master  or sudo automount -f -v
tail -f -n100 /var/log/syslog

handle_packet: type = 3
handle_packet_missing_indirect: token 1, name cao, request pid 2684
attempting to mount entry /host/cao
do_mount: sshfs#cao@10.0.2.2: /host/cao type fuse options rw,nodev,nonempty,noatime,allow_other,reconnect,IdentityFile=/home/vagrant/.ssh/id_rsa,uid=1000,gid=1000,max_read=65536,compression=yes,auto_cache,no_check_root,kernel_cache using module generic
The authenticity of host '10.0.2.2 (10.0.2.2)' can not be established.
ECDSA key fingerprint is 06:04:f4:37:b3:29:9b:bf:98:d4:2e:a5:ae:1b:26:73.
Are you sure you want to continue connecting (yes/no)? st_expire: state 1 path /host
expire_proc: exp_proc = 139690617267968 path /host
expire_proc_indirect: expire /host/cao
1 remaining in /host
看到有交互式指令
The authenticity of host '10.0.2.2 (10.0.2.2)' can not be established.
想到：autofs service是root运行，切换到root用户验证一下

root@ubox:~# ssh cao@10.0.2.2
The authenticity of host '10.0.2.2 (10.0.2.2)' can not be established.
ECDSA key fingerprint is 06:04:f4:37:b3:29:9b:bf:98:d4:2e:a5:ae:1b:26:73.
Are you sure you want to continue connecting (yes/no)? no
Host key verification failed.

果然如此，

you have two options:

1) 'ssh -o StrictHostKeyChecking=no' to connect to the host, it will auto add the fingerprint to known_hosts

2) If you create ~/.ssh/config with
Code:
StrictHostKeyChecking no

in it, it will disable the prompt, and all hosts will be automatically added to the known_hosts file.

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no

现在 start autofs
cd /host就可以看到想要的效果啦！
