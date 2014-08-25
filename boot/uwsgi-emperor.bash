#!/usr/bin/env bash 
#Created from mksh on 2014年 08月 25日 星期一 12:27:41 CST

user=${1:-$USER}
uwsgi_bin=`which uwsgi`
vassals_dir=/etc/uwsgi
sudo mkdir -p $vassals_dir
sudo touch /var/log/emperor.log
sudo chown $user:$user /var/log/emperor.log

cat <<-Script >/tmp/emperor.conf
description "uWSGI Emperor Job"
start on runlevel [2345]
stop on runlevel [06]
setuid $user
setgid $user
exec $uwsgi_bin --die-on-term --emperor $vassals_dir --logto /var/log/emperor.log
Script

sudo mv -b /tmp/emperor.conf /etc/init
echo Write conf file to /etc/init/emperor.conf
