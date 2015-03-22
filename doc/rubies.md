https://github.com/sstephenson/ruby-build/wiki#troubleshooting

注意：
有时有些错误，安装了包后，最好吧/opt/rbenv/sources/2.2.0 包删了后再重新安装，以便重新编译！！！

### rbenv install -kv 2.1.1

https://github.com/sstephenson/ruby-build/issues/526

https://github.com/sstephenson/ruby-build/wiki

If you're using rbenv:

    remove --user-install flag from /etc/gemrc.
    If you get error with readline during the build of ruby, use the RUBY_CONFIGURE_OPTS to specify where to find libreadline.so. By example, to install ruby 2.1.1, use the whole following command: RUBY_CONFIGURE_OPTS=--with-readline-dir="/usr/lib/libreadline.so" rbenv install 2.1.1.

  sudo apt-get -y install libreadline-dev
  locate libreadline.so
  RUBY_CONFIGURE_OPTS=--with-readline-dir="/usr/lib/x86_64-linux-gnu/libreadline.so" rbenv install -kv 2.1.1

### rbenv install -kv 2.2.0

linking shared-object fiddle.so
/usr/bin/ld: ./libffi-3.2.1/.libs/libffi.a(raw_api.o): relocation R_X86_64_32S against `.rodata' can not be used when making a shared object; recompile with -fPIC


ref: https://github.com/sstephenson/ruby-build/issues/690#issuecomment-68113987

Please install libffi-dev via apt-get or use '--enabled-shared' option

sudo apt-get -y install libffi-dev

https://github.com/sstephenson/ruby-build/wiki#build-failure-of-fiddle-with-ruby-220
