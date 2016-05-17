" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2002 Sep 19
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc
"
filetype off
call pathogen#incubate()
call pathogen#helptags()
execute pathogen#infect()

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=start,eol,indent

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
  set backupdir=/Users/rodin/backup
  " Persistent undo
  set undodir=/Users/rodin/backup
  set undofile
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set ignorecase
set smartcase

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  "set guifont=Consolas
  set guifont=Source\ Code\ Pro
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

  au BufRead,BufNewFile *.pde set filetype=arduino
  au BufRead,BufNewFile *.ino set filetype=arduino

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

set cursorline
set t_Co=256
set background=dark
color blackboard

"let g:solarized_termcolors = 256  " New line!!
"let g:solarized_termtrans=1
"colorscheme solarized
set tabstop=4
set shiftwidth=4
set scrolloff=3
set formatoptions=qroct
set number
set nowrap

if has("gui_running")

	" Remove menu bar
	set guioptions-=m

	" Remove toolbar
	set guioptions-=T

	" Turn off the blinking cursor
	set gcr=n:blinkon0
endif


" Security concerns
set nomodeline


" Turn off annoying beeping
set vb

" Always move visually
map j gj
map k gk

" Whitespace settings for different filetypes
if has("autocmd")
	filetype on
	filetype plugin indent on
	autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
	autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab wrap linebreak nolist breakindent
	autocmd FileType xml setlocal ts=2 sts=2 sw=2 expandtab wrap linebreak nolist breakindent
	autocmd FileType xslt setlocal ts=2 sts=2 sw=2 expandtab wrap linebreak nolist
	autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab wrap linebreak nolist
	autocmd FileType javascript setlocal ts=4 sts=4 sw=4 expandtab
	autocmd FileType xml setlocal ts=2 sts=2 sw=2 expandtab wrap linebreak nolist
	autocmd FileType text setlocal ts=8 sts=8 sw=8 noexpandtab linebreak wrap nolist breakindent
	autocmd FileType tex setlocal ts=4 sts=4 sw=4 expandtab wrap linebreak nolist breakindent
	autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab colorcolumn=80 omnifunc=pythoncomplete#Complete
	autocmd FileType matlab setlocal ts=4 sts=4 sw=4 expandtab colorcolumn=80
	autocmd FileType markdown setlocal ts=8 sts=8 sw=8 noexpandtab wrap linebreak nolist breakindent
	autocmd FileType arduino setlocal ts=2 sts=2 sw=2 expandtab wrap linebreak nolist
endif

command! -nargs=* Wrap set wrap linebreak nolist

" The all important leader
let mapleader = " "

" Things I do often
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>w :w<CR>
nmap <Leader><Leader> V
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
noremap <C-a> ^
noremap <C-e> $

" Only use pyflakes, not pep8
let g:syntastic_python_checkers=['pyflakes']
let g:ipy_completefunc='none'

function! TogglePep8()
	let s:pep8_ind = index(g:syntastic_python_checkers, 'pep8')
	if s:pep8_ind >= 0
		call remove(g:syntastic_python_checkers, s:pep8_ind)
	else
		call add(g:syntastic_python_checkers, 'pep8')
	endif
endfunction

map <leader>p :call TogglePep8()<CR>

let python_version_2 = 1
let python_highlight_all = 1

"s:pep8_ind Gundo
map <leader>g :GundoToggle<CR>

" CtrlP
map C-p :CtrlP

" NERD Tree
nmap <leader>e :NERDTreeToggle<CR>

" Insert literal TAB character always
inoremap <C-Tab> <Tab> 

" Supertab
let g:SuperTabDefaultCompletionType = "context"

" Airline
set laststatus=2

" Tagbar
nmap <leader>t :TagbarToggle<CR>
let g:tagbar_autoclose=1

" IPython
let g:ipy_monitor_subchannel=0
