#!/usr/bin/env bash
set -e
install_version=${1:-$VERSION}
if [[ "$install_version" = "2.6"* ]];then
  version2dot6=1
  #[ -n "$version2dot6" ]
fi

echo ref: http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/
which mongod &>/dev/null && echo Already exists mongod && exit 1

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
mongo_source=/etc/apt/sources.list.d/mongodb.list
[ -e $mongo_source ] ||{ echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list; }
sudo apt-get update

if [ -n "$version2dot6" ];then
  sudo apt-get install mongodb-org
  #sudo apt-get install mongodb-org=2.6.1 mongodb-org-server=2.6.1 mongodb-org-shell=2.6.1 mongodb-org-mongos=2.6.1 mongodb-org-tools=2.6.1
  ##Pin a specific version
  #echo "mongodb-org hold" | sudo dpkg --set-selections
  #echo "mongodb-org-server hold" | sudo dpkg --set-selections
  #echo "mongodb-org-shell hold" | sudo dpkg --set-selections
  #echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
  #echo "mongodb-org-tools hold" | sudo dpkg --set-selections
else  #main for 2.4
  #You cannot install this package concurrently with the mongodb, mongodb-server, or mongodb-clients packages provided by Ubuntu.
  sudo apt-get install mongodb-10gen
  #install a specific version
  # sudo apt-get install mongodb-10gen=2.2.3
  # echo "mongodb-10gen hold"| sudo dpkg --set-selections #prevent unintended upgrades
fi

cat <<Doc
configure:
 * init script: /etc/init/mongod.conf, /etc/mongod.conf
 * data: /var/lib/mongo
 * log:  /var/log/mongo
 * sudo service mongodb start|stop|restart
 or manual installation:
   http://docs.mongodb.org/manual/tutorial/install-mongodb-on-linux/
   可安装多个版本，默认数据文件在/data/db
Doc
