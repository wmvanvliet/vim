" Run both javascript and vue linters for vue files.
let b:ale_linter_aliases = ['javascript', 'vue']

" Select the eslint linter.
let b:ale_linters = ['eslint']
let b:ale_vue_eslint_executable = 'npx eslint'

let b:ale_fixers = {
\   'javascript': ['eslint'],
\   'vue': ['eslint'],
\   'css': ['eslint'],
\   'json': ['eslint'],
\}

" When writing vue code, we want prettier to auto-format on the fly
let b:ale_fix_on_save = 1
