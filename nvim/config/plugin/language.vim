" Tagbar
" 打开Tagbar [非插入模式]
" nnoremap <Leader>tb :TagbarToggle<CR>
let g:vista_default_executive = 'nvim_lsp'
let g:vista_sidebar_position = 'vertical topleft'
nnoremap <Leader>tb :Vista!!<CR>

" Tabbar在左侧显示
" let g:tagbar_left=1

" a.vim
nnoremap <Leader>hh :A<CR>
nnoremap <Leader>av :AV<CR>

" SingleCompile
nnoremap <F7> :SCCompileRun<cr>
call SingleCompile#ChooseCompiler('python', 'python3')

" indentLine
" let g:indentLine_enabled = 1
" let g:indentLine_fileType = ['python', 'yaml', 'json', 'javascript']

" nerdcommenter
" Add spaces after comment delimiters by default
" let g:NERDSpaceDelims = 1


call SingleCompile#ChooseCompiler('python', 'python3')
nmap <F5> :SCCompile<cr>
nmap <F7> :SCCompileRun<cr>

let g:mkdp_preview_options = { 'uml': {'server': 'https://plantuml.lightxue.com'} }
nnoremap <Leader>md :MarkdownPreviewToggle<CR>

nnoremap <Leader>ij <CMD>%!jq --indent 4<CR>
vnoremap <Leader>ij :!jq --indent 4<CR>
nnoremap <Leader>is <CMD>%!sqlformat - -rs -k upper<CR>
vnoremap <Leader>is :!sqlformat - -rs -k upper<CR>
