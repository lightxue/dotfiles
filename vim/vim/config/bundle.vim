
source ~/.vim/bundle/vim-plug/plug.vim
call plug#begin('~/.vim/bundle')

" 补全
" Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" 语言
Plug 'Yggdroot/indentLine'
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
Plug 'yuttie/comfortable-motion.vim'

"文件/系统
Plug 'pthrasher/conqueterm-vim', { 'on': ['ConqueTermVSplit', 'ConqueTermTab'] }
Plug 'sillybun/vim-repl'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'vim-scripts/Rename'
Plug 'vim-scripts/auto_mkdir'
Plug 'mcchrish/nnn.vim'
Plug 'scrooloose/nerdtree'
if exists('g:nerd_font')
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'ryanoasis/vim-devicons'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
endif

" 其它
Plug 'flazz/vim-colorschemes'
Plug 'lightxue/SwissCalc'

call plug#end()

" TODO
" snippets
" nerd tree failed
" vim-visual-multi

" CoCInstal coc-marketplace
" CoCInstal coc-json
" CoCInstal coc-tsserver
" CoCInstal coc-html
" CoCInstal coc-css
" CoCInstal coc-vetur
" CoCInstal coc-yaml
" CoCInstal coc-python
" CoCInstal coc-highlight
" CoCInstal coc-snippets
" CoCInstal coc-git
" CoCInstal coc-yank
" CoCInstal coc-vimlsp
" CoCInstal coc-emoji
" CoCInstal coc-source
" CoCInstal coc-word
" CoCInstal coc-sql
" CoCInstal coc-ecdit
