set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11

set guioptions-=T  "remove toolbar
set guioptions+=m  "show menubar
set guioptions+=r  "show right-hand scroll bar
set guioptions-=l  "remove left-hand scroll bar

set background=light
colorscheme lucius

vmap <c-c> "+y<CR>
vmap <c-x> "+d<CR>
vmap <c-v> "+p<CR>
nmap <c-v> "+p<CR>
imap <c-v> <esc>"+p<CR>
