"Using vundle as vim plugin manager from 20120212
"
"新增一个从github来的vim plugin
"Bundle 'xxx/xxx'
"run: BundleInstall,  ref boot/gnome-vim
"
"====Basic settings
set nocompatible               " be iMproved
"无论何种模式，都开启鼠标,在终端里很有用。虽然能导致无法复制的问题，也比取消了方便
"can use mouse click to resize multi-window size
set mouse=a
set number                     " display line number

" softtabs, 2 spaces
" good for enter to new line!!!
set tabstop=2
set shiftwidth=2
set expandtab

filetype off                   " required!

"==== Bundle manage plugins
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle' 

"Bundles here:
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
Bundle 'rodjek/vim-puppet.git'
Bundle 'scrooloose/nerdcommenter'
"echo "Plugin 'rking/ag.vim'" >> ~/.vimrc && vim +BundleInstall
Plugin 'rking/ag.vim'
"let g:agprg="/usr/bin/ag --column"

" vim-scripts repos
" need wmctrl on ubuntu by sudo apt-get install wmctrl
Bundle 'shell.vim--Odding'
Bundle 'ctags.vim'
Bundle 'taglist.vim'
"Bundle 'FuzzyFinder'
Bundle 'The-NERD-tree'
Bundle 'NERD_Tree-and-ack'
Bundle 'snipMate'
Bundle 'SnipMgr'
Bundle 'L9'

" color solution
Bundle 'molokai'
" non github repos
Bundle 'git://git.wincent.com/command-t.git'

filetype plugin indent on     " required! 
filetype plugin on     
let mapleader=","

"==NERD tree settings
map <silent> <F12> :NERDTreeToggle<CR>
cmap w!! %!sudo tee>/dev/null %

"==molokai
"use black background solution...
colorscheme molokai
set t_Co=256

"设定文件编码类型，彻底解决编码问题, gb2312编码等
let &termencoding=&encoding
set fileencodings=utf-8,gbk,ucs-bom,cp936
