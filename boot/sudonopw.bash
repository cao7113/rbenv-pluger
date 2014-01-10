#!/usr/bin/env bash

#sudo $0
set -e
if [[ "$(id -un)" != "root" ]];then
  echo Require root or sudo to run this && exit 1
fi

name=sudonopw

if [ -s /etc/sudoers.d/$name ];then
  echo Has configured file: /etc/sudoers.d/$name && exit 2
fi 

sudo groupadd --force --system $name && echo Added a $name group

cat <<-Note >/tmp/$name && echo Created a file: /tmp/$name 
%$name ALL=NOPASSWD: ALL
Note

chmod 0440 /tmp/$name
sudo mv /tmp/$name /etc/sudoers.d/

echo Has build file: /etc/sudoers.d/$name

cat <<-Note
Add an existed user into $name group by: sudo usermod -a -G $name someone
or Create a new user by: sudo useradd -s /bin/bash -m --system -G $name someone
Note
