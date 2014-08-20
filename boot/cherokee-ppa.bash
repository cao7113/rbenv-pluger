#!/usr/bin/env bash 

set -e

sudo apt-get -y install python-software-properties
#Note: on 20140820 Not support 14.04 ref: https://launchpad.net/~cherokee-webserver/+archive/ubuntu/ppa 
#Now working on: 12.04, 13.04, 13.10
sudo add-apt-repository -y ppa:cherokee-webserver/ppa
# A tmp workaround
codename=$(lsb_release -sc)
if [ "$codename" = "trusty" ];then
  #12.04 precise, 13.10 saucy
  tmp_src=${1:-precise}
  sudo sed -i -e "s/$codename/$tmp_src/" /etc/apt/sources.list.d/cherokee-webserver* 
  echo Workarond for trusty release, replace with $tmp_src in /etc/apt/sources.list.d/chero* ...
  echo Enter to continue or change setting in another windown!
  read
fi

sudo apt-get -y update
#sudo apt-get -y install cherokee cherokee-admin
# libcherokee-mod-streaming not work for 14.04 
sudo apt-get -y install cherokee cherokee-admin cherokee-doc libcherokee-mod-libssl libcherokee-mod-rrd

#run by: sudo cherokee-admin -b --unsecure
# admin port at 9090

echo Ok
