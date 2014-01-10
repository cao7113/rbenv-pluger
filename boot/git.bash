#!/usr/bin/env bash
set -e
if [ "$1" != "-f" ];then
  which git >/dev/null && echo Has installed git ... && exit 1
else
  shift
fi

sudo apt-get -y install git && echo Installing git ... 
git config --global user.name ${1:-cao7113}
git config --global user.email ${2:-cao7113@hotmail.com}

etc_dir=$(dirname $0)/../etc
ln -sb $etc_dir/etc/dot.gitconfig ~/.gitconfig && echo Make a local link to ~/.gitconfig
ln -sb $etc_dir/etc/dot.gitignore ~/.gitignore && echo Make a local link to ~/.gitignore
sudo apt-get -y install gitk
echo end.
