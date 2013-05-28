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
  set backupdir=/home/marijn/backup
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set ignorecase
set smartcase

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  set guifont=Consolas
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

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Spellcheck
cab spell :w<CR>:!aspell -c  %<CR>:e<CR><CR>
cab espell :w<CR>:!newsbody -qs -n % -p aspell check \%f<CR>:e<CR><CR>

"color darkblue
color blackboard
set tabstop=4
set shiftwidth=4
set scrolloff=3
set formatoptions=qroct
set number
set nowrap

if has("gui_running")
	set cursorline

	" Remove menu bar
	set guioptions-=m

	" Remove toolbar
	set guioptions-=T
endif


" Make
map <C-B> :make<CR>

" goto line quickly
map - G

" Taglist
let Tlist_Ctags_Cmd = '/usr/local/bin/exctags'

" Security concerns
set nomodeline

" Folding
" set foldmethod=marker
"set foldclose=all

" Turn off annoying beeping
set vb

set statusline="%<%f\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).\"\,\"}%{\"\ \".&ff}%{(&eol==0?\",noeol\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P"

map j gj
map k gk

noremap <silent> ZC :bo vs<cr>Ljzt:setl scb<cr><c-w>p:setl scb<cr>

" if has("multi_byte")
" 	if &termencoding == ""
" 		let &termencoding = &encoding
" 	endif
" 	set encoding=utf-8
" 	setglobal fileencoding=utf-8 bomb
" 	set fileencodings=ucs-bom,utf-8,latin1
" endif

" Whitespace settings for different filetypes
if has("autocmd")
	filetype on
	filetype plugin indent on
	autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
	autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab wrap linebreak nolist
	autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab wrap linebreak nolist
	autocmd FileType javascript setlocal ts=4 sts=4 sw=4 expandtab
	autocmd FileType xml setlocal ts=2 sts=2 sw=2 expandtab wrap linebreak nolist
	autocmd FileType text setlocal ts=8 sts=8 sw=8 noexpandtab wrap linebreak nolist
	autocmd FileType tex setlocal ts=4 sts=4 sw=4 expandtab wrap linebreak nolist
	autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab colorcolumn=80 omnifunc=pythoncomplete#Complete
	autocmd FileType matlab setlocal ts=4 sts=4 sw=4 expandtab colorcolumn=80
endif

command! -nargs=* Wrap set wrap linebreak nolist

" Only use pyflakes, not pep8
let g:syntastic_python_checkers=['pyflakes']

" Gundo
map <leader>g :GundoToggle<CR>
let g:SuperTabDefaultCompletionType = "context"

" CtrlP
let g:ctrlp_map = '<leader>t'
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0

" NERD Tree
nmap <leader>e :NERDTreeToggle<CR>

