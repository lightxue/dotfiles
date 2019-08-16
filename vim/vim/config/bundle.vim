
source ~/.vim/bundle/vim-plug/plug.vim
call plug#begin('~/.vim/bundle')

"补全
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

"Plug 'vim-scripts/Align'
"Plug 'vim-scripts/AuthorInfo'
"Plug 'vim-scripts/DoxygenToolkit.vim'
"Plug 'vim-scripts/DrawIt'
"Plug 'vim-scripts/TeTrIs.vim'
"Plug 'vim-scripts/VOoM'
"Plug 'vim-scripts/VimPdb'
"Plug 'altercation/vim-colors-solarized'
"Plug 'asins/vimcdoc'
"Plug 'vim-scripts/bufexplorer.zip'
"Plug 'vim-scripts/minibufexpl.vim'
"Plug 'Shougo/unite.vim'
Plug 'romainl/Apprentice'
Plug 'posva/vim-vue'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'Chiel92/vim-autoformat'
Plug 'vim-scripts/scratch.vim'
Plug 'tpope/vim-repeat'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-scripts/YankRing.vim'
Plug 'mileszs/ack.vim'
Plug 'vim-scripts/Auto-Pairs'
Plug 'jpalardy/vim-slime', { 'for': 'lisp' }
Plug 'mbbill/fencview'
Plug 'vim-scripts/Gundo'
Plug 'vim-scripts/JSON.vim'
Plug 'vim-scripts/LargeFile'
Plug 'Lokaltog/vim-easymotion'
Plug 'vim-scripts/Mark'
"Plug 'vim-scripts/Pydiction'
Plug 'vim-scripts/Rename'
"Plug 'vim-scripts/SearchComplete'
Plug 'vim-scripts/SingleCompile'
"Plug 'SirVer/ultisnips'
Plug 'vim-scripts/Tagbar', { 'for': ['c', 'cpp', 'python'] }
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
"Plug 'vim-scripts/VimRepress'
"Plug 'vim-scripts/VisIncr'
Plug 'Yggdroot/indentLine', { 'for': 'python' }
Plug 'vim-scripts/ZenCoding.vim', { 'for': 'html' }
Plug 'vim-scripts/a.vim', { 'for': ['c', 'cpp'] }
Plug 'vim-scripts/auto_mkdir'
"Plug 'vim-scripts/blackboard.vim'
"Plug 'vim-scripts/calendar.vim--Matsumoto'
Plug 'vim-scripts/ctrlp.vim'
Plug 'godlygeek/tabular'
Plug 'hdima/python-syntax', { 'for': 'python' }
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
"Plug 'vim-scripts/indentpython'
Plug 'junegunn/vim-easy-align'
Plug 'lightxue/SwissCalc'
Plug 'vim-scripts/matchit.zip'
Plug 'vim-syntastic/syntastic'
"Plug 'vim-scripts/matrix.vim--Yang'
"Plug 'mmai/wikilink'
Plug 'vim-scripts/molokai'
"Plug 'vim-scripts/mru.vim'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'pthrasher/conqueterm-vim'
Plug 'vim-scripts/pydoc.vim', { 'for': 'python' }
"Plug 'vim-scripts/rainbow_parentheses.vim'
"Plug 'oblitum/rainbow'
Plug 'luochen1990/rainbow'
Plug 'sjas/csExplorer', { 'for': 'css' }
"Plug 'vim-scripts/taglist.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'uarun/vim-protobuf', { 'for': 'protobuf' }
"Plug 'vim-scripts/vcscommand.vim'
Plug 'sheerun/vim-polyglot'
"Plug 'marijnh/tern_for_vim'
Plug 'benmills/vimux'
"Plug 'vim-scripts/vimwiki'
"Plug 'airblade/vim-rooter'
Plug 'airblade/vim-gitgutter'
"Plug 'wlangstroth/vim-racket'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!']  }

call plug#end()
