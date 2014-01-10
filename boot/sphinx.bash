#!/bin/bash
#Created from mksh on 2012年 10月 23日 星期二 11:52:17 CST
#Description: 
#Usage:  $0 [-r [remote_files_url]]

sphinx_home=/usr/local  #default install into /usr/local
echo "==Install full-text search support using sphinx-for-chinese into rails project (installed: $sphinx_home ) ..."
[ -e $sphinx_home/bin/searchd ] && echo ==Maybe have installed sphinx in $sphinx_home, please check it! && exit 1

if [ "$1" == '-r' ];then
  #http://sphinx-for-chinese.googlecode.com/files/sphinx-for-chinese-2.1.0-dev-r3361.tar.bz2
  #http://sphinx-for-chinese.googlecode.com/files/xdict_1.1.tar.gz
  prefix_url="${2:-http://sphinx-for-chinese.googlecode.com/files}"
else
  prefix_url=http://192.168.1.60:5000/files/sphinx  #service from cao
fi
sp_pkg=sphinx-for-chinese-2.1.0-dev-r3361.tar.bz2
dict_pkg=xdict_1.1.tar.gz

tmp_sphinx_dir=/tmp/sphinx_$$
mkdir -p $tmp_sphinx_dir
cd $tmp_sphinx_dir
echo ==Using pkg home: $tmp_sphinx_dir ...
[ ! -e $sp_pkg ] && wget $prefix_url/$sp_pkg && echo "==Downloading $sp_pkg using $prefix_url"
[ ! -e $dict_pkg ] && wget $prefix_url/$dict_pkg && echo "==Downloading $dict_pkg using $prefix_url"
sp=${sp_pkg/.tar.bz2/}
tar -jxvf $sp_pkg
cd $sp 
./configure --prefix=$sphinx_home --with-mysql && make && sudo make install
cd ..
echo ==Installed $sp ...

dict=${dict_pkg/.tar.gz/}
echo ==Installing $dict...
tar -xvf $dict_pkg
#从xdict_1.1.txt生成xdict文件，xdict_1.1.txt文件可以根据需要进行修改
$sphinx_home/bin/mkdict xdict_1.1.txt xdict 
sudo cp -b xdict $sphinx_home/etc/  #necessary?
echo ==Installed $dict ...

echo ==Have installed chinesed-sphinx into $sphinx_home using $tmp_sphinx_dir packages...
