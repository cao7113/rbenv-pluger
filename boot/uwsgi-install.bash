#!/usr/bin/env bash 
set -e 

echo ref: http://uwsgi-docs.readthedocs.org/en/latest/Install.html
#requires: gcc/clang, python(to run uwsgiconfig.py)
sudo apt-get -y install build-essential python libssl-dev libpcre3-dev 
#!!! Require: ruby has installed with development headers
#For distro's ruby development heladers, sudo apt-get -y install ruby-dev

#download source and do one of: 
#wget http://projects.unbit.it/downloads/uwsgi-latest.tar.gz
#tar zxvf uwsgi-latest.tar.gz
#cd <dir> 
#make rack # or UWSGI_PROFILE=rack make;  or make PROFILE=rack; or python uwsgiconfig.py --build rack

#newwork installer, read the script!!
#prof=${1:-rack}  
prof=${1:-ruby2}  #Note: on ruby 2.x, to support rbthreads use ruby2 profile
bin_path=${2:-/opt/uwsgi/latest/uwsgi}
if [ -e $bin_path ];then
  echo Found $bin_path!!!
  exit 0
fi
bin_dir=$(dirname $bin_path)
sudo mkdir -p $bin_dir && sudo chown -R $USER:$USER $bin_dir
curl http://uwsgi.it/install | bash -s $prof $bin_path #a monolithic uWSGI binary support ruby/rack
sudo ln -sb $bin_path /usr/local/bin/uwsgi #into PATH
echo Has installed uwsgi at $bin_path with $prof support

<<-Note #snapshot from http://uwsgi.it/install
echo "*** uWSGI installer ***"
if [ $# -ne 2 ]
then
  echo "Usage: install.sh <profile> <binary_path>"
  exit 1
fi

if [ ${2:0:1} != "/" ]
then
  echo "uWSGI binary path must be absolute !!!"
  exit 1
fi

echo "downloading latest uWSGI tarball..."
curl -o uwsgi_latest_from_installer.tar.gz http://projects.unbit.it/downloads/uwsgi-latest.tar.gz
mkdir uwsgi_latest_from_installer
tar zvxC uwsgi_latest_from_installer --strip-components=1 -f uwsgi_latest_from_installer.tar.gz
cd uwsgi_latest_from_installer
UWSGI_PROFILE="$1" UWSGI_BIN_NAME="$2" make
Note

#in ruby way install the latest stable release
#gem install uwsgi --verbose --debug #有时很慢？ 可见使用的ruby2 profile, 通用使用了上面的脚本（在项目根目录下install.sh文件）

#rbthreads is a plugin need to load??
#Ruby 1.9/2.0 introduced an improved threads support and uWSGI supports it via the ‘rbthreads’ plugin. This plugin is automatically built when you compile the uWSGI+ruby (>=1.9) monolithic binary.
#All of these methods build a “monolithic” uWSGI binary. Other mode is build core and dynamic load plugins

<<-Note  ##install python/wsgi support uwsgi
sudo apt-get -y install python-dev
#choices from:
pip install uwsgi
pip install http://projects.unbit.it/downloads/uwsgi-lts.tar.gz
#network installer
curl http://uwsgi.it/install | bash -s default /tmp/uwsgi #(this will install the uWSGI binary into /tmp/uwsgi, feel free to change it).

#download source and build
wget http://projects.unbit.it/downloads/uwsgi-latest.tar.gz
tar zxvf uwsgi-latest.tar.gz
#cd <dir> 
make #or python uwsgiconfig.py --build
#after the build you will have a uwsgi binary in the current directory.

At the end of the build, you will get a report of the enabled features. If something you require is missing, just add the development headers and rerun the build. For example to build uWSGI with ssl and perl regexp support you need libssl-dev and pcre headers.

uWSGI has a really fast development cycle, so packages may not be up to date. Building it requires less than 30
seconds and very few dependencies (only Python interpreter, a C compiler/linker and the libs/headers for your language
of choice)
Note

echo ok
