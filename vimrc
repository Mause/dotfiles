" Vim needs a POSIX-Compliant shell. Fish is not.
if $SHELL =~ 'bin/fish'
 set shell=/bin/sh
endi

set expandtab
set shiftwidth=4
set softtabstop=4
set mouse=a

syntax enable

set nocompatible  " be iMproved, apparently
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-python/python-syntax'

Plugin 'Quramy/tsuquyomi'

Plugin 'vim-scripts/fish.vim'
Plugin 'daylerees/colour-schemes', {'rtp': 'vim/'}
call vundle#end()

colorscheme Darkside

let g:python_highlight_all = 1

filetype plugin indent on
