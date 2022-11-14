" IPython integration
let g:ipy_completefunc='none'
let g:ipy_monitor_subchannel = 0
let g:jupyter_mapkeys = 0
vnoremap <Leader>x <Plug>JupyterRunVisual
nnoremap <C-Return> :JupyterSendCell<CR>
nnoremap <Leader><Return> :JupyterSendCell<CR>
nnoremap <Leader>x <Plug>JupyterRunTextObj
nnoremap <Leader>X :JupyterRunFile<CR>
nnoremap <Leader>c :JupyterConnect<CR>
nnoremap <Leader>d :JupyterStartDebugger<CR>
nnoremap <Leader>D :VimspectorReset<CR>

" Python linting
let b:ale_linters = ['flake8']
"let b:ale_linters = ['flake8', 'mypy']
"let b:ale_linters = ['pyright']
"let g:ale_python_pyright_executable = "/l/vanvlm1/node-v16.15.1-linux-x64/bin/pyright-langserver"
"let g:ale_python_pyright_config = {"python.analysis.typeCheckingMode": "off"}

" By default, don't worry about PEP8
let g:ale_python_flake8_options = "--ignore=E2,E3,E4,E5,E7,W"
let g:ale_python_mypy_options = "--ignore-missing-imports"
let g:python_highlight_space_errors = 0

" Function to enable PEP8 checking
function! TogglePep8()
  if g:ale_python_flake8_options == ""
	let g:ale_python_flake8_options = "--ignore=E2,E3,E4,E5,E7,W"
    set colorcolumn=0
	let g:python_highlight_space_errors = 0
  else
    let g:ale_python_flake8_options = ""
    set colorcolumn=80
	let g:python_highlight_space_errors = 1
  endif
endfunction

" Python PEP8 checking
nnoremap <leader>8 :call TogglePep8()<CR>

" Function for converting newline separated words into a python list
function! MakeList()
	s/ \?, \+/', '/g
	s/^/['/
	s/$/']/
	noh
endfunction
command! MakeList call MakeList()

"" Set python path for completion to work properly
"function! SetupPythonPath()
"	let pythonpath = system('python -c "import sys; print(sys.path)"')
"	python import vim, sys; sys.path = eval(vim.eval('pythonpath'))
"endfunction
"if has("autocmd")
"	autocmd FileType python call SetupPythonPath()
"endif

" Language servers
if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

" Syntex highlighting
let g:python_highlight_func_calls=0
