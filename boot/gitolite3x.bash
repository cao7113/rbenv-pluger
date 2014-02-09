#!/usr/bin/env bash

set -e
echo https://github.com/sitaramc/gitolite INSTALLATION AND SETUP
[ -d /home/git ] && echo Warn: found /home/git && exit 1
[ $# -lt 1 ]&& echo Usage: $0 admin_pub && exit 1
admin_pub=$1

sudo apt-get -y install git openssh-server && echo install git and ssh server
sudo useradd -m -s /bin/bash git && echo create a git user
sudo cp -b $admin_pub /home/git/
pubfile=`basename $admin_pub`
sudo chown git:git /home/git/$pubfile

sudo -u git -H -i <<-More
  if [ ! -d gitolite ];then
    git clone git://github.com/sitaramc/gitolite && echo Clone gitolite repo
  else
    echo Use current gitolite repo
  fi
  mkdir -p \$HOME/bin
  gitolite/install -to \$HOME/bin
  \$HOME/bin/gitolite setup -pk $pubfile
  cd \$HOME && rm -f $pubfile && echo Remove useless file
More
echo Install /home/git as git user...
