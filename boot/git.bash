#!/usr/bin/env bash
set -e

sudo apt-get -y install git && echo Installing git ... 

etc_dir=$(readlink -f $(dirname $0)/../etc)
ln -sb $etc_dir/dot.gitconfig ~/.gitconfig && echo Make a local link to ~/.gitconfig
ln -sb $etc_dir/dot.gitignore ~/.gitignore && echo Make a local link to ~/.gitignore

#git config --global user.name ${1:-cao7113}
#git config --global user.email ${2:-cao7113@hotmail.com}
echo end.
