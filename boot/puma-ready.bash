#!/usr/bin/env bash

# 让一个应用满足puma部署的条件

set -e
app_dir=${1:-$PWD}

function ensure_dir(){
  dir=$app_dir/$1
  file=$dir/${2:-.gitkeep}
  if [ ! -f $file ];then
    mkdir -p $dir && touch $file
    echo file: $file
  fi
}

ensure_dir log
ensure_dir public

if [ ! -f $app_dir/config/puma.rb ];then
  mkdir -p $app_dir/config
  cat <<-Note >$app_dir/config/puma.rb
app_root = File.expand_path('../..', __FILE__)
environment 'production'
bind "unix:///#{app_root}/tmp/puma.sock"
Note
  echo create a init file $app_dir/config/puma.rb
fi  

echo Make $app_dir pumalize deployment ready!
