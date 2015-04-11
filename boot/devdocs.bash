#!/usr/bin/env bash 

dir=~/dev/devdocs

if [ -d $dir ];then
  echo Found existed $dir
else
  cd $dir/..
  git clone https://github.com/Thibaut/devdocs.git && cd devdocs
  #gem install bundler
  bundle install
  thor docs:download --all
  #rackup
fi
