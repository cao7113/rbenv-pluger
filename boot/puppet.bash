#!/usr/bin/env bash 
#This just for open source puppet, not Puppet Enterprise

set -e
#on ubuntu, supprt: precise, trusty

#pre-install
echo require ruby installed !

apt_pkg_url=https://apt.puppetlabs.com/puppetlabs-release-$(lsb_release -sc).deb
dest_file=/tmp/$(basename $apt_pkg_url)
if [ ! -f $dest_file ];then
  echo Ref: http://docs.puppetlabs.com/guides/install_puppet/install_debian_ubuntu.html
  echo ==Step1: for newest versions of Puppet, enable the Puppet Labs Package Repository ... 
  echo get $apt_pkg_url to $dest_file ...
  wget -O $dest_file  $apt_pkg_url 
fi
sudo dpkg -i $dest_file
sudo apt-get -y update

## for two types of deployment: agent/master or standalone

if [ "$1" = "master" ];then
  echo Step2: Install puppet on the Puppet Master Server, skip this for a standalone deployment
  #sudo apt-get install puppetmaster-passenger #recommended with production-capacity web server using Passenger+Apache2
  sudo apt-get -y install puppetmaster #use Webrick as the default web server, just for test; require config a better rack-based server!
  echo Install puppet, its prerequisties and an init script at /etc/init.d/puppetmaster for master daemon!
  #when upgrade
  #sudo apt-get update
  #sudo puppet resource package puppetmaster ensure=latest
fi

echo Install Puppet on Agent nodes or standalone mode
sudo apt-get -y install puppet
#when upgrade
#sudo apt-get update
#sudo puppet resource package puppet ensure=latest
echo install puppet and init script at /etc/init.d/puppet for agent daemon

#post-install
echo configure for agent/master mode by http://docs.puppetlabs.com/guides/install_puppet/post_install.html
