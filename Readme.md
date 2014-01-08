#Rbenv-pluger: a rbenv-plugin manager

manage rbenv plugins like rbenv manage rubies.

## Install

* Rbenv has installed: install this like normal rbenv-plugin
* Rbenv has not installed

  intall rbenv with this pluger using one shell script in: recipe/rbenv. (Note: tested on ubuntu12.04)

  like this https://github.com/fesplugas/rbenv-installer

## Usage

  `rbenv help pluger`

## Note

  share/plug/*: just shell snippet, sourced when installed!
  recipe/*:     some recipes

## Ref:

* https://github.com/sstephenson/rbenv
* http://ruby-china.org/wiki/rbenv-guide
* https://github.com/sstephenson/rbenv/wiki/Plugins
* https://github.com/znz/rbenv-plug
* https://github.com/taqtiqa/rbenv-plugin

other plugins you maybe intrested:

* https://github.com/fesplugas/rbenv-bootstrap

integreate in other environments: 

* https://github.com/capistrano/rbenv
* https://github.com/fnichol/chef-rbenv
* https://github.com/RiotGames/rbenv-cookbook
