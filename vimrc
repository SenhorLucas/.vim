set relativenumber number " Relative lines with absolute line number at cursor
set nowrap                " Do not wrap long lines
set encoding=utf-8
set hidden                " Allows to switch buffers without saving

" ------------
" Keybindings:
" ------------
" Split navigations
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>

" Buffer switching
nnoremap <C-k> :bn<CR>
nnoremap <C-j> :bp<CR>
nnoremap <C-x> :bd<CR>


" =======STATUS LINE============
" Show status line
set laststatus=2
function! GitBranch()
    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
    let l:branchname = GitBranch()
    return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m\
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
" set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
" set statusline+=\[%{&fileformat}]
set statusline+=\ %p%%
set statusline+=\ %l:%c\|%L
" set statusline+=\ %L%*               "total line
" set statusline+=%*%L%*               "total line
" set statusline+=\
" =================================== END STATUS LINE=========

" newtr adaptations
" set the default vizualisation: i
let g:netrw_liststyle=3
" Set banner hidden by default: I
let g:newtr_banner=0
" delete newtr's buffer when it is hidden to prevent typing :qa!
autocmd FileType newtr setl bufhidden=delete

" :find settings. Fuzzy search
set nocompatible            "Fuzzy search only current project
set path+=**                "Include subdirectories
set wildmenu                "Press tab to enter wild menu

" Increment with <C-i>
nn <C-i> <C-a>

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
"=========== Taskfiles===========
autocmd BufRead,BufNewFile Taskfile set syntax=yaml

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


" ============PLUGINS===============
" vimawesome.com: that's where I find the plugins
"
" VimPlug:
" --------
" The minimalistic plugin manager.
"
" * Installation:
"     curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" * vimrc:
"   In ~/.vimrc insert `Plug` commands between `call plug#begin` and `call
"   plug#end
"
" * Commands:
"   - PlugInstall [name] [#threads]
"   - PlugUpdate [name] [#threads]
"   - PlugClean[!]
"   - PlugStatus
"   - PlugDiff
"

" Vim-plug
call plug#begin('~/.vim/plugged')


    " --------------------
    " CtrlP: Fuzzy finder!
    " --------------------
    "
    " Basic Usage:
    "   * `:help ctrlp-commands` `:help ctrlp-extensions`
    "   * `:CtrlP [dir]`: File find mode
    "   * `:CtrlPBuffer` `:CtrlPMRU`: Buffer or MRU modes
    "   * `:CtrlPMixed`: Search file, buffer and MRU simultaneously.
    "
    " Commands:
    "   * <F5> to purge the cache for the current directory to get new files,
    "   remove deleted files and apply new ignore options.
    "   * <c-f> and <c-b> to cycle between modes.
    "   * <c-d> to switch to filename only search instead of full path.
    "   * <c-r> to switch to regexp mode.
    "   * <c-j>, <c-k> or the arrow keys to navigate the result list.
    "   * <c-t> or <c-v>, <c-x> to open the selected entry in a new tab or in a
    "   new split.
    "   * <c-n>, <c-p> to select the next/previous string in the prompt's
    "   history.
    "   * <c-y> to create a new file and its parent directories.
    "   * <c-z> to mark/unmark multiple files and <c-o> to open them
    " Plug 'ctrlpvim/ctrlp.vim'
    " let g:ctrlp_map = '<c-p>'
    " let g:ctrlp_cmd = 'CtrlP'


    " -----------------
    " FZF: Fuzzy finder
    " -----------------
    "
    " PlugUpdate fzf
    " Basic Usage:
    " * <C-J> or <C-K> move cursor
    " * <tab> select item
    "
    " Syntax:
    " * ' exact
    " * ^ $ begin, end
    " * ! invert
    " * | or
    " * <space> andj
    "
    " Env:
    " * FZF_DEFAULT_COMMAND='fd --type f'
    " * FZF_DEFAULT_OPTIONS="--layout=reversed --inline-info"
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    nnoremap <silent> <C-f> :Files<CR>

    " Hacky way to make rg not search file names!
    command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
    " grep for text in files
    nnoremap <silent> <Space>f :Rg<CR>
    " Optional remaps from fzf.vim
    nnoremap <silent> <Space>b :Buffers<CR>
    nnoremap <silent> <Space>/ :BLines<CR>
    " nnoremap <silent> <Leader>' :Marks<CR>
    " nnoremap <silent> <Leader>g :Commits<CR>
    " nnoremap <silent> <Leader>H :Helptags<CR>
    " nnoremap <silent> <Leader>hh :History<CR>
    " nnoremap <silent> <Leader>h: :History:<CR>
    " nnoremap <silent> <Leader>h/ :History/<CR> 


    " --------------------------
    " Syntastic: Syntax checking
    " --------------------------
    "
    Plug 'scrooloose/syntastic'

    " Bracket pair colorizer
    Plug 'luochen1990/rainbow'
    let g:rainbow_active = 1

    Plug 'vim-scripts/indentpython.vim'

    " Auto Completion with YouCompleteMe
    Plug 'Valloric/YouCompleteMe'
    " Let clangd fully control code completion
    let g:ycm_clangd_uses_ycmd_caching = 0
    " Use installed clangd, not YCM-bundled clangd which doesn't get updates.
    let g:ycm_clangd_binary_path = exepath("clangd")

    Plug 'zivyangll/git-blame.vim'
    nnoremap <Space>s :<C-u>call gitblame#echo()<CR>
    " Plug 'pboettch/vim-cmake-syntax'
    Plug 'vhdirk/vim-cmake'
    Plug 'flazz/vim-colorschemes'
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'mfukar/robotframework-vim'
call plug#end()

colorscheme molokai
syntax off
syntax on
