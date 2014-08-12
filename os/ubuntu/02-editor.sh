#!/bin/bash
#-------------------------------------------------------------------------------

# Install Vim editor.
apt-get -y install vim || exit 20

# Set Vim options
if [ ! -e "$HOME/.vimrc" ]
then
( cat <<'EOP'
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set number
set showmatch
set hlsearch
set incsearch
set smartcase
set backspace=2
set autoindent
set textwidth=79
set ruler
set background=dark
filetype plugin indent on
syntax on
EOP
) > "$HOME/.vimrc" || exit 21
fi