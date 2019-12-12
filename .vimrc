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

command Q q
command W w
nnoremap 0 ^
nnoremap ^ 0

" If I actually want to type the string "jk" i need to do jjkak :')
imap jk <Esc>

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
Plugin 'tpope/vim-surround'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/nerdcommenter'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'justinmk/vim-sneak'

" Nerdtree
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs' " Keeps NERDTree independent of tabs

" Language support
Plugin 'fatih/vim-go'
Plugin 'ap/vim-css-color' " color preview in CSS
Plugin 'keith/swift.vim'
Plugin 'wlangstroth/vim-racket'
Plugin 'rust-lang/rust.vim'
Plugin 'hhvm/vim-hack'

" Completion and Linting
Plugin 'vim-syntastic/syntastic'
Plugin 'w0rp/ale'
Plugin 'paredit.vim'
"Plugin 'ludovicchabant/vim-gutentags'
Plugin 'python/black'

" Writing mode
Plugin 'dbmrq/vim-ditto'
Plugin 'junegunn/goyo.vim'

call vundle#end()
filetype plugin indent on

" Aesthetics
syntax on
colorscheme gruvbox
set t_Co=256
set background=dark

let file_name = expand('%:t:r')
if file_name == "BUCK"
    set syntax=python
endif

" Ale
let g:ale_cpp_clang_options = '-std=c++14 -Wall'
let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace', 'prettier'],
    \ 'python': ['black'],
\ }
let g:ale_fix_on_save = 1
"autocmd BufWriteCmd *.py ALEFix

" Writing mode
let g:write_mode = 0
function ToggleWriteMode()
    if !g:write_mode
        Goyo
        let g:write_mode = 1
    else
        Goyo
        let g:write_mode = 0
    endif
endfunction
nnoremap <leader>w :call ToggleWriteMode()<CR>
nnoremap <leader>d :Ditto<CR>


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

" Fix rendering on kitty
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

" Hack things
if v:version >= 800
  let g:ale_completion_enabled = 1
  nnoremap <silent> K :ALEHover<CR>
  nnoremap <silent> gd :ALEGoToDefinition<CR>
  nnoremap <M-LeftMouse> <LeftMouse>:ALEGoToDefinition<CR>

  " show type on hover
  if v:version >= 801
    set balloonevalterm
    let g:ale_set_balloons = 1
  endif
endif
