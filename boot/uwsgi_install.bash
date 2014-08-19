#!/usr/bin/env bash 
echo ref: http://uwsgi-docs.readthedocs.org/en/latest/Install.html

#require: python, gcc/clang

#ubuntu
#sudo apt-get install build-essential python

#with python/wsgi support
#sudo apt-get install python-dev

#make or python uwsgiconfig.py --build
#or pip uwsgi

#or gem(it will build a binary with ruby/rack support)
#gem install uwsgi

#At the end of the build, you will get a report of the enabled features. If something you require is missing, just add the development headers and rerun the build. For example to build uWSGI with ssl and perl regexp support you need libssl-dev and pcre headers.
