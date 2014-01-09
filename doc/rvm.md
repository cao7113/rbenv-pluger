# Learn and borrow from RVM

* rvm dependencies by `rvm requirements` on ubuntu:

  Requirements for Linux ( DISTRIB_ID=Ubuntu
  DISTRIB_RELEASE=10.10
  DISTRIB_CODENAME=maverick
  DISTRIB_DESCRIPTION="Ubuntu 10.10" )

  NOTE: 'ruby' represents Matz Ruby Interpreter (MRI) (1.8.X, 1.9.X)
  This is the original / standard Ruby Language Interpreter
  'ree' represents Ruby Enterprise Edition
  'rbx' represents Rubinius

  bash >= 4.1 required
  curl is required
  git is required (>= 1.7 for ruby-head)
  patch is required (for 1.8 rubies and some ruby-heads).

  To install rbx and/or Ruby 1.9 head (MRI) (eg. 1.9.2-head), then you
  must install and use rvm 1.8.7 first.

  Additional Dependencies:
  # For Ruby / Ruby HEAD (MRI, Rubinius, & REE), install the following:
  ruby: /usr/bin/apt-get install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion pkg-config

  # For JRuby, install the following:
  jruby: /usr/bin/apt-get install curl g++ openjdk-6-jre-headless
  jruby-head: /usr/bin/apt-get install ant openjdk-6-jdk

  # For IronRuby, install the following:
  ironruby: /usr/bin/apt-get install curl mono-2.0-devel

## Ref

* https://rvm.io/
