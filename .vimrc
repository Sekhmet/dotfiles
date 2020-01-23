set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'chriskempson/base16-vim'

Plugin 'pangloss/vim-javascript'
Plugin 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['javascript'] }

call vundle#end()            " required
filetype plugin indent on    " required

" Colors
let base16colorspace=256
colorscheme base16-eighties

" Basic config
syntax on
set number
set relativenumber
set cursorline

" Plugins
let g:prettier#autoformat = 0
autocmd BufWritePre *.js Prettier

