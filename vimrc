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
Plugin 'FooSoft/vim-argwrap'
Plugin 'gerw/vim-HiLinkTrace'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'kana/vim-textobj-user'
Plugin 'majutsushi/tagbar'
Plugin 'mileszs/ack.vim'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-tbone'
Plugin 'wmvanvliet/python-syntax'
Plugin 'wmvanvliet/vim-blackboard'
Plugin 'wmvanvliet/jupyter-vim'
Plugin 'wmvanvliet/vim-kerbulator'
Plugin 'rust-lang/rust.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'dense-analysis/ale'
Plugin 'ervandew/supertab'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'jalvesaq/Nvim-R'
Plugin 'andymass/vim-matlab'
Plugin 'JuliaEditorSupport/julia-vim'
Plugin 'https://github.com/snakemake/snakemake.git', {'rtp': 'misc/vim/'}
Plugin 'snakemake/snakefmt'
Plugin 'gmoe/vim-soul'
Plugin 'heavenshell/vim-pydocstring'
Plugin 'posva/vim-vue'
Plugin 'puremourning/vimspector'
Plugin 'dpelle/vim-LanguageTool'
Plugin 'sudar/vim-arduino-syntax'

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
  au BufRead,BufNewFile *.asm set filetype=asm
  au BufRead,BufNewFile *.qml set filetype=qml
  au BufRead,BufNewFile *.gml set filetype=xml
endif

set autoindent    " always set autoindenting on

set cursorline
set t_Co=256
"set termguicolors
set background=dark
color blackboard
"color goodwolf

" I usually have a dark background that I would like terminal Vim to use
hi Normal ctermbg=NONE

" Render these strings as comments
"highlight link pythonMultiString Comment
highlight link rustCommentLineDoc Comment

set tabstop=4
set shiftwidth=4
set scrolloff=3
set formatoptions=qroctj
set number
set nowrap
set signcolumn=yes
set nojoinspaces  " When joining lines, don't put two spaces after a period (.)

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
        "set guifont=Fira\ 14
        "set guifont=Consolas\ 14
        "set guifont=Luxi\ Mono\ 14
        "set guifont=Input\ 12
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
  autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType vue setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType julia setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType xml setlocal ts=2 sts=2 sw=2 expandtab wrap linebreak nolist
  autocmd FileType text setlocal ts=8 sts=8 sw=8 noexpandtab linebreak wrap nolist breakindent
  autocmd FileType tex setlocal ts=4 sts=4 sw=4 expandtab wrap linebreak nolist breakindent
  "autocmd FileType tex set guifont=Luxi\ Mono\ 14
  autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab completeopt-=preview
  autocmd FileType r setlocal ts=4 sts=4 sw=4 expandtab completeopt-=preview
  autocmd FileType matlab setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType markdown setlocal ts=4 sts=4 sw=4 expandtab wrap linebreak nolist breakindent
  autocmd FileType rst setlocal ts=4 sts=4 sw=4 expandtab wrap linebreak nolist breakindent
  autocmd FileType arduino setlocal ts=2 sts=2 sw=2 expandtab wrap linebreak nolist
  autocmd FileType nasm setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType asm setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType vim setlocal ts=2 sts=2 sw=2 expandtab

  " No beeps or flashing please
  set noerrorbells visualbell t_vb=
  autocmd GUIEnter * set visualbell t_vb=
endif

command! -nargs=* Wrap set wrap linebreak nolist

" Things I do often
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
nnoremap <C-a> ^
nnoremap <C-e> $

set pyx=3
set pythonthreedll=/m/work/modules/Ubuntu/20.04/amd64/common/neuroimaging/miniconda3/envs/neuroimaging/lib/libpython3.9.so
let python_version_2 = 0  " Python 3 by default
let python_highlight_all = 1

" File pane
nnoremap <leader>e :Lex<CR>
let g:netrw_winsize = 40  " Width of the file explorer panel

" Tagbar
nnoremap <leader>t :Tagbar<CR>

" Insert literal TAB character always
inoremap <C-Tab> <Tab>

" Copy/paste
nnoremap Y y$
if exists('$TMUX')
  map <leader>y :Tyank<CR>
  map <leader>p :Tput<CR>
else
  map <leader>y "+y
  map <leader>p "+p
endif
map <leader>Y "+y$
map <leader>P "+P

" Surround function object
nnoremap <silent> dsf ds)db
nnoremap <silent> csf %cb

" GitGutter
nnoremap <leader>s :GitGutterSignsToggle<CR>
let g:gitgutter_signs = 0

" Airline
set laststatus=2

" Argwrap
nnoremap <silent> <leader>a :ArgWrap<CR>

" Indent guides
let g:indent_guides_auto_colors = 0

" i3 sometimes does a poor job of resizing gvim, making the command prompt
" disappear. We make its height 2 so it always shows.
set cmdheight=2

" Show undo tree
let g:gundo_prefer_python3 = 1
nnoremap <leader>u :GundoToggle<CR>

" Quickly switch between the current and previous file
nnoremap ` :e#<CR>

" Quickly fix spelling using the first match
nnoremap <leader>z z=1<CR><CR>

" Trim spaces at EOL and retab.
command! TEOL %s/\s\+$//
command! CLEAN retab | TEOL

" Fuzzy search
"norenmap ; :CtrlPBuffer<CR>
"norenmap <Leader>o :CtrlP<CR>
"norenmap <Leader>f :CtrlP .<CR>
nnoremap ; :Buffers<CR>
nnoremap <Leader>o :GFiles<CR>
nnoremap <Leader>f :Files .<CR>
nnoremap <Leader>; :BTags<CR>
let g:fzf_preview_window = []

" Configure Ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Autocompletion
set omnifunc=ale#completion#OmniFunc
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']

" Only run linter when saving
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1
let g:ale_lint_on_insert_leave = 0

" Diffs
set diffopt=filler,internal,algorithm:histogram,indent-heuristic

" Tags for markdown files
let g:tagbar_type_markdown = {
  \ 'ctagstype': 'markdown',
  \ 'ctagsbin' : '~/.local/bin/markdown2ctags.py',
  \ 'ctagsargs' : '-f - --sort=yes --sro=»',
  \ 'kinds' : [
      \ 's:sections',
      \ 'i:images'
  \ ],
  \ 'sro' : '»',
  \ 'kind2scope' : {
      \ 's' : 'section',
  \ },
  \ 'sort': 0,
\ }


" Airline statusline
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_section_b = ''
let g:airline_section_x = ''

" Don't sync the clipboard over a remote connection. Takes way too long.
set clipboard=exclude:.*

let R_assign = 0

" Underlining things
noremap <leader>- yyp^v$r-^
noremap <leader>= yyp^v$r=^
noremap <leader># yyp^v$r#^
noremap <leader>~ yyp^v$r~^

" Debugging
let g:vimspector_enable_mappings = 'HUMAN'

" Spelling and such
let g:languagetool_jar='$HOME/.local/LanguageTool-5.2/languagetool-commandline.jar'
