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
