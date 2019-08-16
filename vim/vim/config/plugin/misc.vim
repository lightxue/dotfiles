" Tabbar在左侧显示
let g:tagbar_left=1

" TxtBrowser          高亮TXT文本文件
au BufRead,BufNewFile *.txt setlocal ft=txt

" :FencView           查看文件编码和更改文件编码
let g:fencview_autodetect=0

"let g:pydiction_location = g:_vimfiles."/bundle/Pydiction/complete-dict"
let g:pydiction_location = '~/.vim/bundle/Pydiction/complete-dict'

"autocmd FileType php setlocal let b:surround_112 = "<?php \n ?>"

let g:indentLine_enabled = 0

"let g:AutoPairsMapCR = 0
" 启动自带的man插件
source $VIMRUNTIME/ftplugin/man.vim

let g:syntastic_ignore_files=[".*\.py$"]

let python_highlight_all = 1
let g:yankring_history_file = '.yankring_history'

let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

let g:slime_target = "tmux"

let g:rooter_disable_map = 1

" 调整python文件类型，python3的优先级比python2高
call SingleCompile#SetCompilerTemplate('python', 'python3', 'CPython 3', 'python3', '', '')
call SingleCompile#SetPriority('python', 'python3', 40)

let NERDTreeIgnore = ['\.pyc$', '^__pycache__$', '\.o$']

let g:rainbow_conf = {
\   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\   'operators': '_,_',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\   'separately': {
\       '*': {},
\       'tex': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\       },
\       'lisp': {
\           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\       },
\       'vim': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\       },
\       'css': 0,
\       'html': 0,
\   }
\}

noremap <F3> :Autoformat<CR>
"let g:formatdef_sql = '"sqlformat --reindent --indent_width 4 --use_space_around_operators --keywords upper --identifiers lower -"'
let g:formatdef_sql = '"sqlfmt --use-spaces --tab-width 4"'
let g:formatters_sql = ['sql']

" vim-slime使用tmux
let g:slime_target = 'tmux'

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
