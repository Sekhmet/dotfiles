call plug#begin(stdpath('data') . '/plugged')

Plug 'sainnhe/everforest'
Plug 'tpope/vim-sleuth'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

colorscheme everforest

set number
set relativenumber

set colorcolumn=80,100,120

nnoremap <C-p> <cmd>Telescope git_files<CR>
nnoremap <C-f> <cmd>Telescope live_grep<CR>
