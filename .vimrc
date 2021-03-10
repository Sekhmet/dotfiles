call plug#begin()

Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'chriskempson/base16-vim'

Plug 'pangloss/vim-javascript'
Plug 'dense-analysis/ale'

call plug#end()

filetype plugin on

" Looks
syntax on
let base16colorspace=256
colorscheme base16-default-dark

set tabstop=2
set shiftwidth=2
set expandtab

set number
set hlsearch

" Keys
nnoremap <silent> <leader><leader> :nohl<CR>
nnoremap <C-p> :FZF<CR>
nnoremap <C-o> :Buffers<CR>

nnoremap <S-j> :m .+1<CR>==
nnoremap <S-k> :m .-2<CR>==

" JavaScript
let g:ale_fixers = {'javascript': ['prettier']}
let g:ale_fix_on_save = 1
