
source ~/.vim/bundle/vim-plug/plug.vim
call plug#begin('~/.vim/bundle')

"补全
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'posva/vim-vue'
Plug 'ConradIrwin/vim-bracketed-paste' " 插入模式C-V自动set paste
Plug 'Chiel92/vim-autoformat' " TODO
Plug 'vim-scripts/scratch.vim'
Plug 'tpope/vim-repeat'
Plug 'mg979/vim-visual-multi'
Plug 'mhinz/vim-startify'
"Plug 'vim-scripts/YankRing.vim' "TODO
Plug 'mileszs/ack.vim'
Plug 'mbbill/fencview'
Plug 'mbbill/undotree'
Plug 'vim-scripts/LargeFile'
Plug 'Lokaltog/vim-easymotion'
Plug 'vim-scripts/Mark'
Plug 'vim-scripts/Rename'
Plug 'vim-scripts/SingleCompile'
Plug 'vim-scripts/Tagbar', { 'on': 'TagbarToggle' }
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'Yggdroot/indentLine', { 'for': ['python', 'yaml', 'json'] }
Plug 'vim-scripts/ZenCoding.vim', { 'for': 'html' }
Plug 'vim-scripts/a.vim', { 'for': ['c', 'cpp'] }
Plug 'vim-scripts/auto_mkdir'
Plug 'godlygeek/tabular'
Plug 'junegunn/vim-easy-align'
Plug 'lightxue/SwissCalc'
Plug 'andymass/vim-matchup'
Plug 'vim-scripts/molokai'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'pthrasher/conqueterm-vim', { 'on': ['ConqueTermVSplit', 'ConqueTermTab'] }
Plug 'luochen1990/rainbow'
Plug 'sjas/csExplorer', { 'for': 'css' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'uarun/vim-protobuf', { 'for': 'protobuf' }
Plug 'sheerun/vim-polyglot' "多文件格式支持
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!']  }
 Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }

call plug#end()

" TODO
" snippets
" coc-yank
" nerd tree  o
" formatter
" nnn.vim
" matchup
" coc-pairs
" mg979/vim-visual-multi

" coc-json for json.
" coc-tsserver for javascript and typescript.
" coc-html for html, handlebars and razor.
" coc-css for css, scss and less.
" coc-vetur for vue, use vetur.
" coc-yaml for yaml
" coc-python for python, extension forked from vscode-python.
" coc-highlight provides default document symbol highlighting and color support.
" coc-snippets provides snippets solution.
" coc-git provides git integration.
" coc-yank provides yank highlights & history.
" coc-vimlsp for viml.
" npm i -g bash-language-server
" go get github.com/mattn/efm-langserver
