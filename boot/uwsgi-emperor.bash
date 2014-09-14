#!/usr/bin/env bash 
#Usage: [APP_USER=xxx] [CONF_DIR=xxx] $0

set -e 

app_user=${APP_USER:-$USER}

#root_dir=$(dirname $0)
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
sudo touch /var/log/emperor.log
sudo chown $app_user:$app_user /var/log/emperor.log

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

exec $bin_uwsgi --master --die-on-term --emperor $conf_dir --logto /var/log/emperor.log
Conf
sudo cp -b $tmpfile $dest
echo Has configured uWSGI emperor to $dest
