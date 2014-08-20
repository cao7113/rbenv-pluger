#!/usr/bin/env bash 

set -e 

#Note: has bug on 20040820 easy install
#wget https://github.com/cherokee/installer/raw/master/install.py && python install.py
#or
#curl -LO https://github.com/cherokee/installer/raw/master/install.py && python install.py

echo Install from source
pkg_url=${1:-https://github.com/cherokee/webserver/archive/v1.2.103.zip}

sudo apt-get -y install autoconf libtool automake
pkg=$(basename $pkg_url)
[ -f $pkg ] || wget $pkg_url 
#zip pkg
pkg_type=${pkg##*.}
if [ "x$pkg_type" == "xzip" ];then
  sudo apt-get -y install unzip
  unzip -qq $pkg
else
  echo Unknown type: $pkg_type for $pkg_url!
  #wget http://www.cherokee-project.com/download/trunk/cherokee-latest-snapshot.tar.gz
  #tar xf cherokee-latest-snapshot.tar.gz
  exit 1
fi
name=${pkg%*.zip}
webname=${name/v/webserver-}
cd $webname
#accept options for ./configure
./autogen.sh --localstatedir=/var --prefix=/usr --sysconfdir=/etc --with-wwwroot=/var/www
echo ===Has configured Not working now, too complex to configure!!!
make
sudo make install
cd -

echo ok
