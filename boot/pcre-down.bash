#!/bin/bash
#Created from mksh on 2012年 08月 26日 星期日 21:11:35 CST
#Description: 
#ref: 
# * http://www.pcre.org/

#[ $# -lt 1 ] && echo Usage: $0 _url _down_homedir_ && exit 1
[ -z $u_pkg_home ] && u_pkg_home=$HOME
pkg_dir=${2:-$u_pkg_home/pcre} && mkdir -p $pkg_dir
_url=ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.32.tar.gz
url=${1:-$_url}
pkg_name=`basename $url`
[ -e $pkg_dir/$pkg_name ] && echo Package $pkg_name has existed in $pkg_dir ... && exit 1
echo ==Downloading $pkg_name into $pkg_dir ...
cd $pkg_dir && wget $url
echo ==ok get $pkg_name from $url !
