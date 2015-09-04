" The MIT License (MIT)
"
" Copyright (c) 2015 Michael Trunner <michael@trunner.de>
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
" THE SOFTWARE.
"

" This .vimrc is based on the sample .vimrc file by Martin Brochhaus
" presented at PyCon APAC 2012

set nocompatible  " be IMproved
runtime bundle-enabled/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect('bundle-enabled/{}')


" Automatic reloading of .vimrc
"autocmd! bufwritepost .vimrc source %

" Allow switching buffers without saving them
set hidden

" Better copy & paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.
set pastetoggle=<F2>
"set clipboard=unnamedplus

" Improve performance
set lazyredraw

" Mouse and backspace
set mouse=a  " on OSX press ALT and click
set bs=2     " make backspace behave like normal again

" Commandline completion
set wildmenu
set wildmode=list:longest,full

set wildignore+=*.o
set wildignore+=*~
set wildignore+=*.pyo
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*

" Rebind <Leader> key
" I like to have it here becuase it is easier to reach than the default and
" it is next to ``m`` and ``n`` which I use for navigating between tabs.
let mapleader = ","

" Quick quit command
noremap <Leader>e :quit<CR>  " Quit current window
noremap <Leader>E :qa!<CR>   " Quit all windows


" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h


" easier moving between buffers
map <Leader>n <esc>:bprevious<CR>
map <Leader>m <esc>:bnext<CR>

" easier moving between tabss
map <Leader>N <esc>:tabprevious<CR>
map <Leader>M <esc>:tabnext<CR>


" map sort function to a key
vnoremap <Leader>s :sort<CR>


" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation


" Enable syntax highlighting
" You need to reload this file for the change to apply
filetype off
filetype plugin indent on
syntax on
set showmatch

" Showing line numbers and length
set number  " show line numbers
set tw=79   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
"set colorcolumn=80
highlight ColorColumn ctermbg=233


" easier formatting of paragraphs
"" vmap Q gq
"" nmap Q gqap


" Useful settings
set history=700
set undolevels=700

" Show whitespaces
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<


" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase


" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" Session management
set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds

"
" Forgotten sudo
"
cmap w!! w !sudo tee > /dev/null %


"
" Color scheme
"
" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/
set t_Co=256
color wombat256mod

"
" CSS Colors
"

" ============================================================================
" IDE Setup
" ============================================================================

"
" Buffergator
"
let g:buffergator_autoexpand_on_split = 0

"
" vim-airline
"
let g:airline#extensions#tabline#enabled = 0
let g:airline_powerline_fonts = 1
set laststatus=2
let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ '' : 'V',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ '' : 'S',
      \ }
function! AirlineInit()
    let g:airline_section_b = airline#section#create(['hunks'])
    let g:airline_section_c = airline#section#create(['%f'])
    let g:airline_section_x = airline#section#create(['tagbar'])
    let g:airline_section_y = airline#section#create(['branch'])
    "let g:airline_section_y = airline#section#create([''])
endfunction
autocmd VimEnter * call AirlineInit()

let g:airline#extensions#bufferline#overwrite_variables = 0

"
" vim-bufferline
"
let g:bufferline_echo = 1

highlight bufferline_selected gui=bold cterm=bold term=bold
highlight link bufferline_selected_inactive airline_c_inactive
let g:bufferline_inactive_highlight = 'airline_c'
let g:bufferline_active_highlight = 'bufferline_selected'
let g:bufferline_active_buffer_left = '['
let g:bufferline_active_buffer_right = ']'
let g:bufferline_fname_mod = ':~:.'

"
" ctrlp
"
let g:ctrlp_max_height = 30

"
" Tagbar
"
map <F3> :TagbarToggle<CR>


"
" NerdTree
"
map <F6> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.py[co]$', '\.[ao]$', '\.so$', '\.class$', '__pycache__']


"
" Gundo
"
nnoremap <F5> :GundoToggle<CR>

"
" Syntastic
"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1

"let g:syntastic_enable_signs = 0

let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✠'
let g:syntastic_warning_symbol = '∆'
let g:syntastic_style_warning_symbol = '≈'

function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
        Errors
    endif
endfunction
nnoremap <silent> <C-e> :<C-u>call ToggleErrors()<CR>


"
" Snippets
"

let g:UltiSnipsExpandTrigger="<tab>"
" <c-tab> doesn't work for me :-(
let g:UltiSnipsListSnippets="<F12>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"


" ============================================================================
" Python Setup
" ============================================================================

autocmd FileType python,c,cpp,java,php set tabstop=4
autocmd FileType python,c,cpp,java,php set softtabstop=4
autocmd FileType python,c,cpp,java,php set shiftwidth=4
autocmd FileType python,c,cpp,java,php set shiftround
autocmd FileType python,c,cpp,java,php set expandtab
autocmd FileType python,c,cpp,java,php autocmd BufWritePre <buffer> :%s/\s\+$//e

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
let g:jedi#usages_command = "<leader>z"
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 1
let g:jedi#usages_command = "<leader>u"
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#show_call_signatures = "0"
let g:jedi#goto_assignments_command ="<leader>a"
autocmd FileType python menu <silent> PopUp.-Jedi- :
autocmd FileType python menu <silent> PopUp.Goto\ &definition<tab>,d ,d
autocmd FileType python menu <silent> PopUp.Goto\ &assignment<tab>,a ,a
autocmd FileType python menu <silent> PopUp.Find\ &usage<tab>,u ,u
autocmd FileType python menu <silent> PopUp.&Rename<tab>,r ,r

autocmd FileType python menu <silent> 80 Python.Goto\ &definition<tab>,d ,d
autocmd FileType python menu <silent> 80 Python.Goto\ &assignment<tab>,a ,a
autocmd FileType python menu <silent> 80 Python.Find\ &usage<tab>,u ,u
autocmd FileType python menu <silent> 80 Python.&Rename<tab>,r ,r

nmap <C-t>n :TestNearest<cr>
menu <silent> 81 Test.Test\ &Nearest<tab>^Tn <C-t>n
nmap <C-f>f :TestFile<cr>
menu <silent> 81 Test.Test\ &File<tab>^Tf <C-t>f
nmap <C-t>s :TestSuite<cr>
menu <silent> 81 Test.Test\ &Suite<tab>^Ts <C-t>s
nmap <C-t>l :TestLast<cr>
menu <silent> 81 Test.Test\ &Last<tab>^Tl <C-t>l
nmap <C-t>v :TestVisit<cr>
menu <silent> 81 Test.Test\ &Visit<tab>^Tv <C-t>v
nmap <C-t>c :cclose<cr>
menu <silent> 81 Test.&Close\ Quickfix<tab>^Tc <C-t>c



let python_highlight_all = 1

map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
"set splitbelow

"
" Auto PEP8
"
let g:autopep8_disable_show_diff = 1

" ensure that python specific files are ignored
set wildignore+=*.pyc
set wildignore+=*.pyo
set wildignore+=*_build/*
set wildignore+=*/coverage/*

"
" VIM Python Test Runner
"

let g:test#python#djangotest#file_pattern = '^test.*\.py$'

function! QuickfixStrategy(cmd)
  set efm+=%A\ \ File\ \"%f\"\\,\ line\ %l\\,\ in\ %m
  execute '!'.a:cmd." 2>&1 | tee /tmp/result.txt"
  silent cfile /tmp/result.txt | cw
endfunction

let g:test#custom_strategies = {'quickfix': function('QuickfixStrategy')}
autocmd FileType python let g:test#strategy = 'quickfix'

"
" VIM startify
"
let g:startify_change_to_vcs_root = 1

