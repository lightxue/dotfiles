" nerdtree
" let NERDTreeIgnore = ['\.pyc$', '^__pycache__$', '\.o$']
" let g:NERDTreeDirArrowExpandable = '▸'
" let g:NERDTreeDirArrowCollapsible = '▾'
" nnoremap <Leader>nt :NERDTreeToggle<CR>
nnoremap <Leader>nt :NvimTreeToggle<CR>

" vim-fugitive
nnoremap <Leader>gs :Git<CR>
nnoremap <Leader>gc :Git commit<CR>
nnoremap <Leader>gl :Git pull<CR>
nnoremap <Leader>gp :Git push<CR>
nnoremap <Leader>gg :Gllog<CR>
nnoremap <Leader>gv :GV<CR>
nnoremap <Leader>gb :GitBlameToggle<CR>
let g:gitblame_enabled = 0
let g:gitblame_date_format = '%Y-%m-%d %H:%M:%S'

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fm <cmd>Telescope git_commits<cr>
nnoremap <leader>ft <cmd>Telescope treesitter<cr>

