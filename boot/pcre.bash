#!/usr/bin/env bash

#wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.30.tar.gz
#install into /usr/local

echo Setup pcre: Perl compaticable regular expression ...

##Get pkg to install
pkg_name=pcre
if [ -z $u_pkg_home ];then
  pkg_home=$HOME/pkgs/$pkg_name
else
  pkg_home=$u_pkg_home/$pkg_name
fi
latest_pkg_path=`ls -1 $pkg_home/$pkg_name-*.tar.gz 2>/dev/null | tail -n1`  #using latest pkg
if [ -z $latest_pkg_path ];then
  echo No $pkg_name pkg in $pkg_home now!
  exit 1
fi
latest_pkg=`basename $latest_pkg_path`
version_name=${latest_pkg/.tar.gz/}

##check pkg and install
installed_flag=$pkg_home/_installed_$version_name
if [ ! -e $installed_flag ];then
  tmp_src_dir=/tmp/$pkg_name
  [ ! -d $tmp_src_dir/$version_name ] && mkdir -p $tmp_src_dir && cd $tmp_src_dir && tar -zxvf $latest_pkg_path -C $tmp_src_dir >/dev/null && echo ==Unpacking $pkg_name into $tmp_src_dir/$version_name ...
  cd $tmp_src_dir/$version_name
  ./configure # /usr/local is the default so no need to prefix
  make
  sudo make install
  echo ==Installed $version_name from tmp dir $tmp_src_dir/$version_name
  touch $installed_flag
else
  echo Has installed $version_name on this machine, check it firstly!
fi
sudo ldconfig # this is important otherwise nginx will compile but fail to load
echo Set done...
