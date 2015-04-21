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

" put this line first in ~/.vimrc
set nocompatible | filetype indent plugin on | syn on

fun! SetupVAM()
  let c = get(g:, 'vim_addon_manager', {})
  let g:vim_addon_manager = c
  let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'

  " Force your ~/.vim/after directory to be last in &rtp always:
  " let g:vim_addon_manager.rtp_list_hook = 'vam#ForceUsersAfterDirectoriesToBeLast'

  " most used options you may want to use:
  " let c.log_to_buf = 1
  " let c.auto_install = 0
  let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
  if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
    execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
        \       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
  endif

  " This provides the VAMActivate command, you could be passing plugin names, too
  call vam#ActivateAddons([], {})
endfun
call SetupVAM()


" Automatic reloading of .vimrc
"autocmd! bufwritepost .vimrc source %


" Better copy & paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.


set pastetoggle=<F2>
"" set clipboard=unnamed


" Mouse and backspace
set mouse=a  " on OSX press ALT and click
set bs=2     " make backspace behave like normal again

" Commandline completion
set wildmenu
set wildmode=list:longest,full

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


" easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>


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


" Showing line numbers and length
VAMActivate numbers
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


" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab


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


"
" Forgotten sudo
"
cmap w!! w !sudo tee > /dev/null %


"
" Color scheme
"
VAMActivate wombat256 hybrid Solarized
" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/
set t_Co=256
color wombat256mod

"
" CSS Colors
"
VAMActivate css_color@skammer

" ============================================================================
" IDE Setup
" ============================================================================

"
" VIM localrc
"
VAMActivate localrc

"
" Buffergator
"
VAMActivate Buffergator
nnoremap <silent> <F7> :BuffergatorToggle<CR>

"
" Settings for powerline
"
"VAMActivate powerline

"
" vim-airline
"
VAMActivate vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

set laststatus=2

"
" ctrlp
"
VAMActivate ctrlp
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*

"
" Tagbar
"
VAMActivate Tagbar
nmap <F8> :TagbarToggle<CR>


"
" NerdTree
"
VAMActivate The_NERD_tree
map <F6> :NERDTreeToggle<CR>
"let NERDTreeMapOpenInTab='<ENTER>'


"
" Gundo
"
VAMActivate github:sjl/gundo.vim
nnoremap <F5> :GundoToggle<CR>

"
" Autoclose
"
VAMActivate AutoClose%2009
VAMActivate surround

"
" Git support
"
VAMActivate fugitive
VAMActivate vim-gitgutter

"
" Syntastic
"
VAMActivate Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

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
VAMActivate vim-snippets UltiSnips

let g:UltiSnipsExpandTrigger="<tab>"
" <c-tab> doesn't work for me :-(
let g:UltiSnipsListSnippets="<F12>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

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
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
"set splitbelow

let python_highlight_all = 1

"
" Autp PEP8
"
VAMActivate github:tell-k/vim-autopep8
autocmd FileType python map <buffer> <F3> :call Autopep8()<CR>
let g:autopep8_disable_show_diff=1


