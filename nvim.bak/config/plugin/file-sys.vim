nnoremap <Leader>nt :Neotree toggle filesystem left<CR>
let g:neo_tree_remove_legacy_commands = 1

" vim-fugitive
nnoremap <Leader>gs :Git<CR>
nnoremap <Leader>gc :Git commit<CR>
nnoremap <Leader>gl :Git pull<CR>
nnoremap <Leader>gp :Git push<CR>
nnoremap <Leader>gg :Gllog<CR>
nnoremap <Leader>gd :Gitsigns diffthis<CR>
nnoremap <Leader>gv :GV<CR>
nnoremap <Leader>gb :GitBlameToggle<CR>
let g:gitblame_enabled = 0
let g:gitblame_date_format = '%Y-%m-%d %H:%M:%S'

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <Cmd>Telescope find_files<CR>
nnoremap <leader>fg <Cmd>Telescope live_grep<CR>
nnoremap <leader>fb <Cmd>Telescope buffers<CR>
nnoremap <leader>fh <Cmd>Telescope help_tags<CR>
nnoremap <leader>fm <Cmd>Telescope oldfiles<CR> " MRU
nnoremap <leader>ft <Cmd>Telescope treesitter<CR>
nnoremap <leader>fp <Cmd>Telescope projects<CR>
nnoremap <leader>fc <Cmd>Telescope neoclip<CR>
