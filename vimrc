" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
" Enable syntax highlighting.
syntax on
" Automatically indent when adding a curly bracket, etc.
set smartindent
" Tabs should be converted to a group of 4 spaces.
" This is the official Python convention
" (http://www.python.org/dev/peps/pep-0008/)
" I didn't find a good reason to not use it everywhere.
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab
" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=999
" Use UTF-8.
set encoding=utf-8
" Status line
set laststatus=2
set statusline=
set statusline+=%-3.3n\
" buffer number
set statusline+=%f\
" filename
set statusline+=%h%m%r%w
" status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}]
" file type
set statusline+=%=
" right align remainder
set statusline+=0x%-8B
" character value
set statusline+=%-14(%l,%c%V%)
" line, character
set statusline+=%<%P
" file position
" Show line number, cursor position.
set ruler
" Display incomplete commands.
set showcmd
" To save, press ctrl-s.
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a

" I put here to use only hjkl
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Search as you type.
set incsearch
" Ignore case when searching.
set ignorecase

" Set display line numbers
set number

" Patogen config
execute pathogen#infect()

"vim-airline
let g:airline#extensions#tabline#enabled=1 
let g:airline_powerline_fonts=1
let g:airline_theme='dark'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_linecolumn_prefix = '¶ '
let g:airline_fugitive_prefix = '⎇ '
let g:airline_paste_symbol = 'ρ'
let g:airline_section_c = '%t'

"Solarized configuration
syntax enable
set background=dark
colorscheme solarized
