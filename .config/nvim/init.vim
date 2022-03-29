call plug#begin(stdpath('data') . '/plugged')

Plug 'sainnhe/everforest'
Plug 'tpope/vim-sleuth'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

colorscheme everforest

set number
set relativenumber

set colorcolumn=80,100,120

nnoremap <C-p> <cmd>Telescope git_files<CR>
nnoremap <C-f> <cmd>Telescope live_grep<CR>

autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)

let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
