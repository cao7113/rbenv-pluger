#!/usr/bin/env bash
#Note: 
#* vim(tiny) not support system paste/copy, using vim-gnome instead

set -e
which vim >/dev/null || sudo apt-get -y install vim-gnome && echo Installing vim-gnome ...
which ctags >/dev/null || sudo apt-get -y install exuberant-ctags && echo Installing exuberant-ctags ...

if [ ! -d ~/.vim/bundle ];then
  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
  etc_dir=$(dirname $0)/../etc
  ln -sb $etc_dir/dot.vimrc ~/.vimrc && echo Make a link ~/.vimrc to $etc_dir/dot.vimrc
  vim +BundleInstall +qall
fi
echo set gnome-vim
