#!/usr/bin/env bash
set -e
echo ref: http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/
which mongod &>/dev/null && echo Already exists mongod && exit 1
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
mongo_source=/etc/apt/sources.list.d/mongodb.list
[ -e $mongo_source ] ||{ echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list; }
sudo apt-get update
sudo apt-get install mongodb-10gen
#install a specific version
# sudo apt-get install mongodb-10gen=2.2.3
# echo "mongodb-10gen hold"| sudo dpkg --set-selections #prevent unintended upgrades
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
