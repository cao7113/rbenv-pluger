#!/usr/bin/env bash

set -e

[ $# -lt 1 ] && echo "Usage: $0 sshuser@sshhost" && exit 1

ssh_account=$1

[ -e ~/.ssh/id_rsa.pub ]||{ echo No ~/.ssh/id_rsa.pub, run: ssh/keygen firstly && exit 1;}

echo "==>Copy public key to remote server:$ssh_account"
#/usr/bin/ssh-copy-id is a shell script, in its heart is:
# ssh user@remote_host "cat >> ~/.ssh/authorized_keys" < ~/.ssh/id_rsa.pub
ssh-copy-id $ssh_account

if ssh $ssh_account ":"; then #在远端执行空命令并获取其成功状态
  echo Ok, autologin to $remote_account
else
  echo Error, can not ssh to $ssh_account
  exit 1
fi
