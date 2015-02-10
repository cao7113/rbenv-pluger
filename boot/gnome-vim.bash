#!/usr/bin/env bash
#Note: 
#* vim(tiny) not support system paste/copy, using vim-gnome instead

set -e
[ "$1" = "--config" ] && exit 1

which vim >/dev/null || sudo apt-get -y install vim-gnome && echo Installing vim-gnome ...
which ctags >/dev/null || sudo apt-get -y install exuberant-ctags && echo Installing exuberant-ctags ...
which git >/dev/null || { echo Not found git && exit 1; }

etc_dir=$(readlink -f $(dirname $0)/../etc)
[ -d ~/.vim/bundle ]||{ 
 mkdir -p ~/.vim/bundle
 git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
 ln -sb $etc_dir/dot.vimrc ~/.vimrc && echo Make a link ~/.vimrc to $etc_dir/dot.vimrc
 vim +BundleInstall +qall
}
echo Has set gnome-vim
