#!/usr/bin/env bash
set -e
#set -x
rbenv_recipe=$(dirname $0)/../recipe/rbenv
RUBY_BUILD_MIRROR_URL=http://ruby.taobao.org/mirrors/ruby/ CONFIGURE_OPTS="--disable-install-doc" RUBY_VERSION=${1:-2.1.2} $rbenv_recipe --debug 
echo has install ruby version $RUBY_VERSION 
