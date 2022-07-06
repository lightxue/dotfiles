" undotree
" nnoremap <Leader>ut :UndotreeToggle<CR>
set undofile
set undodir=~/.vim_undo

nnoremap <Leader>ut :MundoToggle<CR>

" scratch
nnoremap <Leader>ch :Scratch<CR>

" :FencView           查看文件编码和更改文件编码
let g:fencview_autodetect = 0

" vim-which-key
nnoremap <silent> <leader> :WhichKey ','<CR>
