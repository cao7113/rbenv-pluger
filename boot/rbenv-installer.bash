#!/usr/bin/env bash
set -e
set -x
rbenv_recipe=$(dirname $0)/../recipe/rbenv
#RUBY_BUILD_MIRROR_URL=http://ruby.taobao.org/mirrors/ruby/ RUBY_VERSION=${1:-2.1.0} $rbenv_recipe --debug 
RUBY_BUILD_MIRROR_URL=http://ruby.taobao.org/mirrors/ruby/ CONFIGURE_OPTS="--disable-install-doc" RUBY_VERSION=${1:-2.0.0-p481} $rbenv_recipe --debug 

echo Note: 2.1.0/1 has bug with readline ref doc/bugs.md, please use 2.1.2 instead!
