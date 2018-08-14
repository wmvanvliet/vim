filetype off

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'bps/vim-textobj-python'
"Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
Plugin 'FooSoft/vim-argwrap'
Plugin 'gerw/vim-HiLinkTrace'
Plugin 'hynek/vim-python-pep8-indent'
"Plugin 'junegunn/fzf'
"Plugin 'junegunn/fzf.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'kana/vim-textobj-user'
Plugin 'lervag/vimtex'
Plugin 'majutsushi/tagbar'
Plugin 'mileszs/ack.vim'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-python/python-syntax'
"Plugin 'w0rp/ale'
Plugin 'vim-syntastic/syntastic'
Plugin 'wmvanvliet/vim-blackboard'
"Plugin 'wmvanvliet/vim-ipython'
Plugin 'wmvanvliet/jupyter-vim'
Plugin 'wmvanvliet/vim-kerbulator'
Plugin 'rust-lang/rust.vim'

" Allow working with multiple buffers at once
set hidden

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on

" allow backspacing over everything in insert mode
set backspace=start,eol,indent

set backup    " keep a backup file
set backupdir=~/backup
set undodir=~/backup " Persistent undo
set undofile
set history=50 " keep 50 lines of command line history
set ruler  " show the cursor position all the time
set showcmd  " display incomplete commands
set incsearch  " do incremental searching
set ignorecase
set smartcase

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  set linespace=2
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

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
  set autoindent    " always set autoindenting on
endif

set cursorline
set t_Co=256
"set termguicolors
set background=dark
color blackboard
"color goodwolf

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

  " Remove scrollbar
  set guioptions-=r
  set guioptions-=R
  set guioptions-=l
  set guioptions-=L

  " Turn off the blinking cursor
  set gcr=n:blinkon0

  " Set font
  if has("win32")
    set guifont=Consolas:h12
  else
    if has("unix")
      let s:uname = system("uname")
      if s:uname == "Darwin\n"
		set guifont=Menlo:h12
      else
        set guifont=Inconsolata\ 14
      endif
	endif
  endif
endif

" Security concerns
set nomodeline

" Turn off annoying beeping
set vb

" Always move visually
map j gj
map k gk

" Yank untill end of line
noremap Y y$

" Leader key is space
let mapleader = " "

" Allows you to easily replace the current word and all its occurrences.
nnoremap <Leader>rc :%s/\<<C-r><C-w>\>/
vnoremap <Leader>rc y:%s/<C-r>"/

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
  autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab omnifunc=pythoncomplete#Complete
  autocmd FileType matlab setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType markdown setlocal ts=8 sts=8 sw=8 noexpandtab wrap linebreak nolist breakindent
  autocmd FileType arduino setlocal ts=2 sts=2 sw=2 expandtab wrap linebreak nolist

  " No beeps or flashing please
  set noerrorbells visualbell t_vb=
  autocmd GUIEnter * set visualbell t_vb=
endif

command! -nargs=* Wrap set wrap linebreak nolist

" Things I do often
nnoremap <Leader>w :w<CR>
nmap <Leader><Leader> V
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
noremap <C-a> ^
noremap <C-e> $

" Linter
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_save = 1
" let g:ale_linters = {
" \   'python': ['flake8']
" \}
" " By default, don't worry about PEP8
" let g:ale_python_flake8_options = "--ignore=E2,E3,E4,E5,E7,W"
let g:python_highlight_space_errors = 0
let g:syntastic_python_checkers=['pyflakes']
 
" " Function to enable PEP8 checking
" function! TogglePep8()
"   if g:ale_python_flake8_options == ""
" 	let g:ale_python_flake8_options = "--ignore=E2,E3,E4,E5,E7,W"
"     setlocal colorcolumn=0
" 	let g:python_highlight_space_errors = 0
"   else
"     let g:ale_python_flake8_options = ""
"     setlocal colorcolumn=80
" 	let g:python_highlight_space_errors = 1
"   endif
" endfunction

" Function to enable PEP8 checking
function! TogglePep8()
  let s:pep8_ind = index(g:syntastic_python_checkers, 'pep8')
  if s:pep8_ind >= 0
    call remove(g:syntastic_python_checkers, s:pep8_ind)
    setlocal colorcolumn=0
	let g:python_highlight_space_errors = 0
  else
    call add(g:syntastic_python_checkers, 'pep8')
    setlocal colorcolumn=80
	let g:python_highlight_space_errors = 1
  endif
endfunction

" Python PEP8 checking
nmap <leader>8 :call TogglePep8()<CR>

let python_version_2 = 1  " Python 2 by default
let python_highlight_all = 1

" File pane
nmap <leader>e :Lex<CR>

" Tagbar
nmap <leader>t :Tagbar<CR>

" Insert literal TAB character always
inoremap <C-Tab> <Tab> 

" Supertab
" let g:SuperTabDefaultCompletionType = "context"

" Copy/paste
map <leader>y "+y
map <leader>p "+p
map <leader>P "+P

" Surround function object
nmap <silent> dsf ds)db
nmap <silent> csf %cb

" GitGutter
nmap <leader>s :GitGutterSignsToggle<CR>
let g:gitgutter_signs = 0

" IPython
let g:ipy_monitor_subchannel = 0

" VimTex
let g:tex_no_error=1
let g:vimtex_view_method = 'zathura'
"let g:vimtex_view_general_viewer = '/usr/bin/okular'
"let g:vimtex_view_general_options = '--unique @pdf\#src:@line@tex'
"let g:vimtex_view_general_options_latexmk = '--unique'
let g:vimtex_fold_enabled = 0
let g:vimtex_indent_enabled = 0
let g:tex_flavor = 'latex'
let g:vimtex_quickfix_ignore_all_warnings = 1
"if has("autocmd")
"  autocmd FileType tex,bib,plaintex nnoremap <silent><Leader>lm :VimtexCompile<cr>
"  autocmd FileType tex,bib,plaintex nnoremap <silent><Leader>lc :VimtexClean<cr>
"  autocmd FileType tex,bib,plaintex nnoremap <silent><Leader>lw :VimtexWordCount<cr>
"  autocmd FileType tex,bib,plaintex nnoremap <silent><Leader>lv :VimtexView<cr>
"  autocmd FileType tex,bib,plaintex nnoremap <silent><Leader>lt :VimtexTocToggle<CR>
"  autocmd FileType tex,bib,plaintex nnoremap <silent><Leader>ly :VimtexLabelToggle<CR>
"endif

" Airline
set laststatus=2

" Argwrap
nnoremap <silent> <leader>a :ArgWrap<CR>

" Indent guides
let g:indent_guides_auto_colors = 0

" i3 sometimes does a poor job of resizing gvim, making the command prompt
" disappear. We make its height 2 so it always shows.
set cmdheight=2

" Jedi VIM
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = 2
let g:jedi#smart_auto_mappings = 0

" Show undo tree
let g:gundo_prefer_python3 = 1
nmap <leader>u :GundoToggle<CR>

"" Set python path for completion to work properly
"function! SetupPythonPath()
"	let pythonpath = system('python -c "import sys; print(sys.path)"')
"	python import vim, sys; sys.path = eval(vim.eval('pythonpath'))
"endfunction
"if has("autocmd")
"	autocmd FileType python call SetupPythonPath()
"endif

" Quickly switch between the current and previous file
nmap ` :e#<CR>

" Quickly fix spelling using the first match
nmap <leader>z z=1<CR><CR>

" Trim spaces at EOL and retab.
command! TEOL %s/\s\+$//
command! CLEAN retab | TEOL

" Opening files and buffers
nmap ; :CtrlPBuffer<CR>
nmap <Leader>o :CtrlP<CR>
nmap <Leader>f :CtrlP .<CR>
"nmap ; :Buffers<CR>
"nmap <Leader>o :GFiles<CR>
"nmap <Leader>f :Files .<CR>

" Configure Ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" IPython integration
let g:ipy_completefunc='none'

let g:jupyter_mapkeys = 0
vmap <Leader>x <Plug>JupyterRunVisual
nnoremap <C-Return> :JupyterSendCell<CR>
nmap <Leader>x <Plug>JupyterRunTextObj

