" Minimal .vimrc configs
set cursorline
set cursorcolumn
set colorcolumn=80
set number
set shell=zsh
set nocompatible
set backspace=indent,eol,start
set ruler
set autoindent
filetype plugin indent on
set t_Co=256

" Tabs
set tabstop=4
set shiftwidth=4
set expandtab

" Remaps
let mapleader=','


nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap ' `
nnoremap ` '

nnoremap <leader><leader> :set relativenumber!<CR>
nnoremap <leader>t :pu!=strftime('%a %d %b %Y')<CR>

nnoremap <Space> i_<Esc>r

command Q q
command W w

" NerdTree
"autocmd VimEnter * NERDTree " Open NERDTree on startup
"autocmd VimEnter * wincmd p " Start cursor in main window
"let g:nerdtree_tabs_open_on_console_startup=1


" Vundle 
filetype off " required for vundle

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Themes & Interfaces
Plugin 'morhetz/gruvbox'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'itchyny/lightline.vim' " status bar

" Keybindings
Plugin 'tpope/vim-surround' " dank text wrapping
Plugin 'ervandew/supertab' " tab completion
Plugin 'scrooloose/nerdcommenter' " commenting
Plugin 'christoomey/vim-tmux-navigator'

" Nerdtree
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs' " Keeps NERDTree independent of tabs

" Syntax highlighting
Plugin 'fatih/vim-go'
Plugin 'ap/vim-css-color' " color preview in CSS
Plugin 'keith/swift.vim'
Plugin 'wlangstroth/vim-racket'
Plugin 'rust-lang/rust.vim'

" Completion and Linting
Plugin 'vim-syntastic/syntastic'
Plugin 'w0rp/ale'
Plugin 'paredit.vim'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'python/black'

" Writing mode
Plugin 'dbmrq/vim-ditto'
Plugin 'junegunn/goyo.vim'

call vundle#end()
filetype plugin indent on

" Aesthetics 
syntax on
colorscheme gruvbox

let file_name = expand('%:t:r')
if file_name == "BUCK"
    set syntax=python
endif

" Ale
let g:ale_cpp_clang_options = '-std=c++14 -Wall'

" Tags
let g:gutentags_project_root = ['BUCK']
let g:syntastic_enable_racket_racket_checker = 1

" Writing mode
let g:write_mode = 0
function ToggleWriteMode(goyoleave)
    if !g:write_mode
        echom "Write mode on"
        let g:write_mode = 1
        set wrap linebreak nolist " Soft wraps
        " Enable navigation of soft wraps as if they were
        " separate lines
        nnoremap j gj
        nnoremap k gk

        " Quitting Goyo = quitting buffer
        nnoremap ZZ :wqa<CR>
        cmap q qa
        Goyo
    else
        echom "Write mode off"
        let g:write_mode = 0
        set nowrap nolinebreak list
        unmap j
        unmap k
        unmap ZZ
        cunmap q
    endif
endfunction
nnoremap <leader>w :call ToggleWriteMode(0)<CR>
nnoremap <leader>d :Ditto<CR>

function! s:goyo_leave()
    echom "Goyo leave initiated"
    call ToggleWriteMode(1)
endfunction
autocmd! User GoyoLeave nested call <SID>goyo_leave()


" Writing mode syntax highlighting
" TODO make these work in markdown files only
syntax include @CPP syntax/cpp.vim
syntax region cppSnip matchgroup=Snip start="```cpp" end="```" contains=@CPP
hi link Snip SpecialComment

syntax include @PYTHON syntax/python.vim
syntax region pySnip matchgroup=Snip start="```python" end="```" contains=@PYTHON
hi link Snip SpecialComment

let g:vim_markdown_folding_disabled = 1
