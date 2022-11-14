" Linting
let b:ale_linters = ['chktex']

" When linting LaTeX, don't warn about " quotes
let g:ale_tex_chktex_options = "-n18"

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
