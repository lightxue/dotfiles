
source ~/.vim/bundle/vim-plug/plug.vim
call plug#begin('~/.vim/bundle')

"补全
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'ConradIrwin/vim-bracketed-paste' " 插入模式C-V自动set paste
Plug 'Chiel92/vim-autoformat' " TODO
Plug 'vim-scripts/scratch.vim'
Plug 'tpope/vim-repeat'
Plug 'mg979/vim-visual-multi'
Plug 'mhinz/vim-startify'
Plug 'mileszs/ack.vim'
Plug 'mbbill/fencview'
Plug 'mbbill/undotree'
Plug 'vim-scripts/LargeFile'
Plug 'Lokaltog/vim-easymotion'
Plug 'vim-scripts/Mark'
Plug 'vim-scripts/Rename'
Plug 'vim-scripts/SingleCompile'
Plug 'vim-scripts/Tagbar', { 'on': 'TagbarToggle' }
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'Yggdroot/indentLine', { 'for': ['python', 'yaml', 'json', 'javascript'] }
Plug 'vim-scripts/a.vim', { 'for': ['c', 'cpp'] }
Plug 'vim-scripts/auto_mkdir'
Plug 'godlygeek/tabular' " TODO
Plug 'junegunn/vim-easy-align'
Plug 'lightxue/SwissCalc'
Plug 'andymass/vim-matchup'
Plug 'flazz/vim-colorschemes'
Plug 'pthrasher/conqueterm-vim', { 'on': ['ConqueTermVSplit', 'ConqueTermTab'] }
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot' "多文件格式支持
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!']  }
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'jiangmiao/auto-pairs'

call plug#end()

" TODO
" snippets
" coc-yank
" nerd tree  o
" formatter
" nnn.vim
" matchup custom like @startuml
" coc-pairs
" mg979/vim-visual-multi
" vim repl

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
" coc-emoji emoji for markdown
" coc-source review
" coc-word
" CocInstall coc-translator
