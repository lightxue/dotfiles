" nerdtree
let NERDTreeIgnore = ['\.pyc$', '^__pycache__$', '\.o$']
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
nnoremap <Leader>nt :NERDTreeToggle<CR>
" nnoremap <Leader>nt :NvimTreeToggle<CR>

" nnn.vim
" let g:nnn#set_default_mappings = 0
" noremap <Leader>nn :NnnPicker<CR>

" conqueterm-vim
au FileType conque_term set nolist
nmap <Leader>cv :ConqueTermVSplit zsh --login<CR>
nmap <Leader>ct :ConqueTermTab zsh --login<CR>

" vim-repl
let g:repl_program = {
            \   'python': 'bpython',
            \   'default': 'zsh',
            \   'r': 'R',
            \   'lua': 'lua',
            \   'vim': 'vim -e',
            \   'javascript': 'node',
            \   }
" let g:repl_predefine_python = {
            " \   'numpy': 'import numpy as np',
            " \   'matplotlib': 'from matplotlib import pyplot as plt'
            " \   }
            "
let g:repl_exit_commands = {
            \   'node': 'process.exit(0)',
            \   }
let g:repl_cursor_down = 1
let g:repl_python_automerge = 1
nnoremap <leader>rr :REPLToggle<Cr>
tnoremap <C-n> <C-w>N
let g:sendtorepl_invoke_key = "<leader>rs" " repl send
let g:repl_position = 3

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


set statusline^=%{FugitiveStatusline()}%{get(b:,'coc_current_function','')}
