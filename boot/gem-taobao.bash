#!/bin/bash
#Created from mksh on 2013年 08月 20日 星期二 10:24:38 CST

# make default source:rubygems --> china's taobao.org
#handle cases:
#source "https://rubygems.org"
#source :rubygems
#-->into
##comment origin line
#source "http://ruby.taobao.org"

[ "$1" = "-h" ] && echo Usage: $0 Gemfile && exit 1
target=${1:-Gemfile}
[ ! -f $target ] && echo Not found file $target && exit 1
sed -i -r -e 's|^(source .*rubygems.*)$|#\1\nsource "http://ruby.taobao.org"|' $target
echo "change rubygems source --> taobao source in $target" 
