#Rbenv-pluger: a rbenv-plugin manager and booter

* manage rbenv plugins like rbenv manage rubies.
* but not a normal plugin, it manage all my ruby life(from install to maintain) 

## Why

* ruby developed fastly, need multiple ruby versions
* boring with manualy or rvm(heavy)
* dream a daily tool for: 
  * consistent installing in home notebook/office pc/vsp server
  * easily manage my ruby life

  rbenv from 37signals maybe your option. I love it, also some plugins.

## Install

* Rbenv has not installed(Recommended)

  intall rbenv with this pluger using one shell script in: recipe/rbenv. (Note: tested on ubuntu12.04)

  like this https://github.com/fesplugas/rbenv-installer

* Rbenv has installed: install this like normal rbenv-plugin

## Usage

* `rbenv help pluger`
* `rbenv help boot` #oh, maybe just work on ubuntu12.04+

## Note

  share/plug:  just shell snippet, sourced when installed!

  recipe/:     some recipes

  etc/rbenv.d: hooks for plugin (supporting before/after_hook)

About rbenv:

  * 支持自动完成
  * 支持rbenv --debug xxx 选项，相当于设置 RBENV_DEBUG=1并set -x

About ruby-build:

  * 使用-kv选项总是好的
  * rbenv install [Tab] #类似-l，支持自动补全，赞一个！
  * ruby-build可单独使用（高级），选项：--definitions, --lib, --version
  * 支持自定义definition file
  * rbenv install/uninstall支持before_hook/after_hook，可用于系统依赖的安装？
  * 环境变量：
    * RBENV_BUILD_ROOT 存放编译时的源码（-k时），默认为$RBENV_ROOT/sources
    * RUBY_BUILD_CACHE_PATH caching downloaded package files #如$RBENV_ROOT/cache存在，则将此目录设为ruby源码包的缓存之地，在网络不畅达时此项挺有用！

## TODO

* 提交到ubuntu中心
* boot的bundle设计，独立出来，借鉴chef？

## Ref:

* https://github.com/sstephenson/rbenv
* http://ruby-china.org/wiki/rbenv-guide
* https://github.com/sstephenson/rbenv/wiki/Plugins
* https://github.com/znz/rbenv-plug
* https://github.com/taqtiqa/rbenv-plugin

available plugin url: 

  `rbenv pluger url`

other plugins you maybe intrested:

* https://github.com/fesplugas/rbenv-bootstrap
* https://github.com/fesplugas/rbenv-installer

integreate in other environments(capistrano, chef): 

* https://github.com/capistrano/rbenv
* https://github.com/fnichol/chef-rbenv
* https://github.com/RiotGames/rbenv-cookbook
