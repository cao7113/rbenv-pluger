#!/usr/bin/env bash 
#Usage: [APP_USER=xxx] [CONF_DIR=xxx] $0

set -e 

app_user=${APP_USER:-$USER}

root_dir=$(dirname $0)
#PATH=$root_dir:$PATH install

#mk conf dir
conf_dir=${CONF_DIR:-/etc/uwsgi}
if [ -d $conf_dir ];then
  echo Has found $conf_dir 
else
  sudo mkdir $conf_dir
  sudo chown -R $app_user:$app_user $conf_dir
  echo Mkdir $conf_dir
fi

#install emperor init conf
if which rbenv &>/dev/null;then
  bin_uwsgi=`rbenv which uwsgi`
else
  bin_uwsgi=`which uwsgi`
fi

tmpfile=/tmp/uwsgi-emperor.conf
dest=/etc/init/emperor.conf
cat <<-Conf >$tmpfile
#Emperor uWSGI script
#Generated at `date`

description "uWSGI Emperor Job"
start on runlevel [2345]
stop on runlevel [06]

setuid $app_user
setgid $app_user

exec $bin_uwsgi --master --die-on-term --emperor $conf_dir
Conf
sudo cp -b $tmpfile $dest
echo Has configured uWSGI emperor to $dest

exit 0

##########################################################################
# Old??????

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
