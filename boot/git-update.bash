#!/usr/bin/env bash


set -e
cat <<-Note
如果本地已经安装过Git，可以使用升级命令：
sudo apt-get dist-upgrade 
Note

sudo apt-add-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install git

