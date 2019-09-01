
source ~/.vim/bundle/vim-plug/plug.vim
call plug#begin('~/.vim/bundle')

" 补全
" Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" 语言
Plug 'Yggdroot/indentLine', { 'for': ['python', 'yaml', 'json', 'javascript'] }
Plug 'luochen1990/rainbow'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot' "多文件格式支持
Plug 'vim-scripts/Tagbar', { 'on': 'TagbarToggle' }
Plug 'vim-scripts/a.vim', { 'for': ['c', 'cpp'] }

" 文本操作
Plug 'ConradIrwin/vim-bracketed-paste' " 插入模式C-V自动set paste
Plug 'Lokaltog/vim-easymotion'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'andymass/vim-matchup'
Plug 'junegunn/vim-easy-align'
Plug 'lfv89/vim-interestingwords'
Plug 'mg979/vim-visual-multi'
Plug 'thinca/vim-visualstar'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" 编译器设置
Plug 'liuchengxu/vim-which-key'
Plug 'mbbill/fencview'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'vim-scripts/scratch.vim'

"文件/系统
Plug 'mcchrish/nnn.vim'
Plug 'pthrasher/conqueterm-vim', { 'on': ['ConqueTermVSplit', 'ConqueTermTab'] }
Plug 'scrooloose/nerdtree'
Plug 'sillybun/vim-repl'
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/Rename'
Plug 'vim-scripts/auto_mkdir'

" 其它
Plug 'flazz/vim-colorschemes'
Plug 'lightxue/SwissCalc'

call plug#end()

" TODO
" snippets
" nerd tree  o
" nnn.vim
" mg979/vim-visual-multi
" vim repl
" popup meme colorschemes

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
" coc-emoji emoji for markdown
" coc-source review
" coc-word
" coc-sql
" CocInstall coc-translator
