" ============================================================================
" Python Setup
" ============================================================================
VAMActivate github:hdima/python-syntax

"
" Python folding
"
set nofoldenable
autocmd FileType python set foldmethod=indent
nnoremap <space> za
vnoremap <space> zf

"
" Settings for jedi-vim
"
VAMActivate jedi-vim
let g:jedi#usages_command = "<leader>z"
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 1
let g:jedi#usages_command = "<leader>u"
let g:jedi#use_tabs_not_buffers = 0
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
"set splitbelow

let python_highlight_all = 1

"
" Auto PEP8
"
VAMActivate github:tell-k/vim-autopep8
let g:autopep8_disable_show_diff = 1

" ensure that python specific files are ignored
set wildignore+=*.pyc
set wildignore+=*.pyo
set wildignore+=*_build/*
set wildignore+=*/coverage/*

"
" VIM Python Test Runner
"
"set efm+=%-G%.%#lib/python%.%#/site-package%.%#
set efm+=%A\ \ File\ \"%f\"\\,\ line\ %l\\,\ in\ %m
VAMActivate github:JarrodCTaylor/vim-python-test-runner

