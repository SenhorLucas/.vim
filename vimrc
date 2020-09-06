syntax on
colorscheme monokai
set relativenumber
set encoding=utf-8

" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Highlight trailing white spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
" Monre on white spaces
set list!
if has('gui_running')
	set listchars=tab:▶\ ,trail:·,extends:\#,nbsp:.
else
	set listchars=tab:>.,trail:.,extends:\#,nbsp:.
"	set listchars=tab:▶\ ,trail:·,extends:\#,nbsp:.
endif

" ============= C/C++ ============
set tabstop=4
set shiftwidth=4
set expandtab

" =========== JavaScript =========
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

" ===========PYTHON ===============
" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with spacebar
nnoremap <space> za

" PEP8 indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
    \ set textwidth=99

" Vim-plug
call plug#begin('~/.vim/plugged')
" Bracket pair colorizer
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

" Code folding (suggestion from RealPython.com)
Plug 'tmhedberg/SimplyFold'
let g:SimplyFold_docstring_preview=1

" Python indentation
Plug 'vim-scripts/indentpython.vim'

" Python autocompletion
Plug 'Valloric/YouCompleteMe'
call plug#end()
