问题： 

  make[1]:正在离开目录 `/home/cao/.rbenv/sources/2.0.0-p353/ruby-2.0.0-p353
  Generating RDoc documentation #这儿为什么看起来耗费那么长时间，服务器安装时能否通过选现调整不生成文档？

  Generating RI format into /home/cao/.rbenv/sources/2.0.0-p353/ruby-2.0.0-p353/.ext/rdoc...

Answer:

  ref: https://github.com/sstephenson/ruby-build/issues/156

    CONFIGURE_OPTS="--disable-install-rdoc" ruby-build 1.9.3-p194

  ref: ruby source/configure file lino#1558 

    --disable-install-doc   do not install neither rdoc indexes nor C API
                            documents during install
    --disable-install-rdoc  do not install rdoc indexes during install
    --disable-install-capi  do not install C API documents during install

  ref: ruby-build/bin/ruby-build lino#408

    ${!PACKAGE_CONFIGURE:-./configure} --prefix="${!PACKAGE_PREFIX_PATH:-$PREFIX_PATH}" $CONFIGURE_OPTS ${!PACKAGE_CONFIGURE_OPTS} "${!PACKAGE_CONFIGURE_OPTS_ARRAY}"

  可见只有 

    CONFIGURE_OPTS="--disable-install-doc" ruby-build -v 1.9.3-p194

    or

    CONFIGURE_OPTS="--disable-install-doc" rbenv install -v 1.9.3-p194


* rbenv build ruby 2.1.0 error
readline.c:1977:26: error: ‘Function’ undeclared (first use in this function)
rl_pre_input_hook = (Function *)readline_pre_input_hook;
^
readline.c:1977:26: note: each undeclared identifier is reported only once for each function it appears in
readline.c:1977:36: error: expected expression before ‘)’ token
rl_pre_input_hook = (Function *)readline_pre_input_hook;
^
readline.c: At top level:
readline.c:634:1: warning: ‘readline_pre_input_hook’ defined but not used [-Wunused-function]
readline_pre_input_hook(void)
^
make[2]: *** [readline.o] Error 1
make[2]: Leaving directory `/tmp/ruby-build.20140502004823.5335/ruby-2.1.1/ext/readline'
make[1]: *** [ext/readline/all] Error 2
make[1]: Leaving directory `/tmp/ruby-build.20140502004823.5335/ruby-2.1.1'
make: *** [

build-ext] Error 2

Fixed:

* https://github.com/sstephenson/ruby-build/issues/526

curl -fsSL https://gist.github.com/mislav/a18b9d7f0dc5b9efc162.txt | rbenv install --patch 2.1.1
or 
curl -fsSL https://gist.github.com/mislav/a18b9d7f0dc5b9efc162.txt | \
rbenv install --patch --keep 2.1.1

* http://stackoverflow.com/questions/23418227/rbenv-error-compiling-ruby-2-1-1
