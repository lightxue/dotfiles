" undotree
nnoremap <Leader>ut :UndotreeToggle<CR>

" scratch
nnoremap <Leader>ch :Scratch<CR>

" :FencView           查看文件编码和更改文件编码
let g:fencview_autodetect = 0

" vim-which-key
" nnoremap <silent> <leader> :WhichKey ','<CR>

let g:better_escape_shortcut = 'jk'

nnoremap <Leader><Leader>w <cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<CR>
nnoremap <Leader><Leader>b <cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<CR>
nnoremap <Leader><Leader>l <cmd>HopLine<CR>
vnoremap <Leader><Leader>w <cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<CR>
vnoremap <Leader><Leader>b <cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<CR>
vnoremap <Leader><Leader>l <cmd>HopLine<CR>
