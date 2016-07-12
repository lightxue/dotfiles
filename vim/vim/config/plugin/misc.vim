" Tabbar在左侧显示
let g:tagbar_left=1

" TxtBrowser          高亮TXT文本文件
au BufRead,BufNewFile *.txt setlocal ft=txt

" :FencView           查看文件编码和更改文件编码
let g:fencview_autodetect=0

"let g:pydiction_location = g:_vimfiles."/bundle/Pydiction/complete-dict"
let g:pydiction_location = '~/.vim/bundle/Pydiction/complete-dict'

"autocmd FileType php setlocal let b:surround_112 = "<?php \n ?>"

let g:indentLine_loaded = 0

"let g:AutoPairsMapCR = 0
" 启动自带的man插件
source $VIMRUNTIME/ftplugin/man.vim

let g:syntastic_ignore_files=[".*\.py$"]

let python_highlight_all = 1
let g:indentLine_loaded = 1
let g:yankring_history_file = '.yankring_history'

let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

let g:slime_target = "tmux"

let g:rooter_disable_map = 1

call SingleCompile#SetCompilerTemplate('scheme', 'racket', 'racket', 'racket', '', '')
call SingleCompile#SetOutfile('scheme', 'racket', '')
call SingleCompile#ChooseCompiler('scheme', 'racket')

call SingleCompile#SetCompilerTemplate('racket', 'racket', 'racket', 'racket', '', '')
call SingleCompile#SetOutfile('racket', 'racket', '')
call SingleCompile#ChooseCompiler('racket', 'racket')

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
