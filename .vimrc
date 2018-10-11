" Minimal .vimrc configs
set cursorline
set cursorcolumn
set colorcolumn=80
set number
set shell=bash
set nocompatible
set backspace=indent,eol,start
set ruler
set autoindent


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

command Q q
command W w

" Startup
autocmd VimEnter * NERDTree " Open NERDTree on startup
autocmd VimEnter * wincmd p " Start cursor in main window


" Plugin Config
let g:nerdtree_tabs_open_on_console_startup=1


" Vundle 
filetype off " required for vundle

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Visual
Plugin 'dracula/vim'
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

" Language Specific
Plugin 'fatih/vim-go'
Plugin 'ap/vim-css-color' " color preview in CSS
Plugin 'keith/swift.vim'
Plugin 'rust-lang/rust.vim'
call vundle#end()
filetype plugin indent on

" Aesthetics 
syntax on

if expand('%:t') == "BUCK"
    set syntax=python
endif

colorscheme dracula
highlight colorcolumn ctermbg=235

set t_Co=256
