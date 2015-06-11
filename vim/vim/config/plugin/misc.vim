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
