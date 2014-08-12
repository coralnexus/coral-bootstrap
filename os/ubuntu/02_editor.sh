#!/bin/bash
#-------------------------------------------------------------------------------

# Install Vim editor.
echo "1. Ensuring Vim editor"
apt-get -y install vim >/tmp/vim.install.log 2>&1 || exit 20

# Set Vim options
if [ ! -e "$HOME/.vimrc" ]
then
echo "2. Setting default .vimrc configuration"
	
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