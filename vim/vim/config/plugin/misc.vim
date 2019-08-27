" Tabbar在左侧显示
let g:tagbar_left=1

" TxtBrowser          高亮TXT文本文件
au BufRead,BufNewFile *.txt setlocal ft=txt

" :FencView           查看文件编码和更改文件编码
let g:fencview_autodetect = 0

" 启动自带的man插件
source $VIMRUNTIME/ftplugin/man.vim

" 调整python文件类型，python3的优先级比python2高
call SingleCompile#SetCompilerTemplate('python', 'python3', 'CPython 3', 'python3', '', '')
call SingleCompile#SetPriority('python', 'python3', 40)

noremap <F3> :Autoformat<CR>
"let g:formatdef_sql = '"sqlformat --reindent --indent_width 4 --use_space_around_operators --keywords upper --identifiers lower -"'
let g:formatdef_sql = '"sqlfmt --use-spaces --tab-width 4"'
let g:formatters_sql = ['sql']

let g:indentLine_enabled = 1

let g:Lf_ShortcutF = '<leader>ff'
let g:Lf_ShortcutB = '<leader>fb'
nmap <Leader>fm :LeaderfMru<CR>

nnoremap <silent> <leader> :WhichKey ','<CR>
