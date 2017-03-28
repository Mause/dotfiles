if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Vim needs a POSIX-Compliant shell. Fish is not.
if $SHELL =~ 'bin/fish'
 set shell=/bin/sh
endi

set expandtab
set shiftwidth=4
set softtabstop=4

syntax enable

set nocompatible  " be iMproved, apparently
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
"set verbose=10
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-scripts/fish.vim'
Plugin 'daylerees/colour-schemes', {'rtp': 'vim-themes/'}
call vundle#end()

colorscheme Darkside

filetype plugin indent on
