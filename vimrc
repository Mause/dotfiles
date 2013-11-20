if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Vim needs a POSIX-Compliant shell. Fish is not.
if $SHELL =~ 'bin/fish'
 set shell=/bin/sh
endi

set nocompatible  " be iMproved, apparently

set expandtab
set shiftwidth=4
set softtabstop=4

syntax enable
filetype off

set rtp+=~/.vim/bundle/vundle
"set verbose=10
call vundle#rc()
Bundle 'gmarik/vundle'

Bundle 'vim-scripts/fish.vim'
Bundle "daylerees/colour-schemes", {"rtp": "vim-themes/"}

colorscheme Darkside

filetype plugin indent on
