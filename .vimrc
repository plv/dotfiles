" Vundle
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

"" Themes & Interfaces
Plugin 'morhetz/gruvbox'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'itchyny/lightline.vim' " status bar

"" Keybindings
Plugin 'tpope/vim-surround'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/nerdcommenter'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'justinmk/vim-sneak'

"" Nerdtree
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs' " Keeps NERDTree independent of tabs

"" Language support
Plugin 'ap/vim-css-color' " color preview in CSS
Plugin 'keith/swift.vim'
Plugin 'wlangstroth/vim-racket'
Plugin 'rust-lang/rust.vim'
Plugin 'hhvm/vim-hack'

"" Completion, linting, and syntax magic
Plugin 'w0rp/ale'
Plugin 'paredit.vim'

"" Writing & Notes
Plugin 'dbmrq/vim-ditto'
Plugin 'junegunn/goyo.vim'
Plugin 'vimwiki/vimwiki'

call vundle#end()
filetype plugin indent on


" Minimal configs
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
set tabstop=4
set shiftwidth=4
set expandtab


" Maps & Remaps
let mapleader=','

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
command Q q
command W w

nnoremap ' `
nnoremap ` '
nnoremap 0 ^
nnoremap ^ 0

nnoremap <leader><leader> :set relativenumber!<CR>
nnoremap <leader>h :set nohlsearch!<CR>

"" Russian keybindings
""" Russian character mappings so that I can take Russian notes more
""" efficiently. This isn't a toggle.
nnoremap <leader>r :set keymap=russian-jcukenwin<CR>
""" This however, is a toggle between russian and english once <leader>r is
""" activated for the first time.
nnoremap <leader>f a<C-^>


" Aesthetics
syntax on
colorscheme gruvbox
set t_Co=256
set background=dark

"" Fix rendering on kitty
if $TERM == "xterm-kitty"
  let &t_ut=''
  set termguicolors
            let &t_8f = "\e[38;2;%lu;%lu;%lum"
            let &t_8b = "\e[48;2;%lu;%lu;%lum"
    hi Normal guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE
    let &t_ti = &t_ti . "\033]10;#f6f3e8\007\033]11;#242424\007"
    let &t_te = &t_te . "\033]110\007\033]111\007"
    set background=dark
endif


" Language, Syntax, and Tooling
"" Various python-like config formats
augroup py_config_syn
    au BufRead,BufNewfile BUCK,TARGETS,*.cconf set filetype=python
augroup END

"" Ale
let g:ale_cpp_clang_options = '-std=c++14 -Wall'


" Writing & Notes
let g:vimwiki_list = [{'path': '~/notes/'}]
let g:vim_markdown_folding_disabled = 1

"" Goyo-powered writing mode
function! s:goyo_enter()
    let g:write_mode = 1
    set wrap linebreak nolist " Soft wraps
    " Enable navigation of soft wraps as if they were
    " separate lines. TODO: there's probably a smarter way to do this
    nnoremap j gj
    nnoremap k gk
    nnoremap $ g$
    nnoremap 0 g0

    cmap q qa
    map ZZ :wq<CR>
endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()

function! s:goyo_leave()
    set nowrap nolinebreak
    unmap j
    unmap k
    unmap $
    unmap 0

    unmap ZZ
    cunmap q
endfunction

"" Various note-taking utilities
nnoremap <leader>d :pu!=strftime('= %a %d %b %Y =')<CR>ji
nnoremap <leader>t :pu!=strftime('== %X  ==')<CR>ji
nnoremap <leader>g :Goyo<CR>

