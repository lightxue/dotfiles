
source ~/.vim/bundle/vim-plug/plug.vim
call plug#begin('~/.vim/bundle')

"补全
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

Plug 'posva/vim-vue'
Plug 'ConradIrwin/vim-bracketed-paste' " 插入模式C-V自动set paste
Plug 'Chiel92/vim-autoformat' " TODO
Plug 'vim-scripts/scratch.vim'
Plug 'tpope/vim-repeat'
Plug 'terryma/vim-multiple-cursors'
"Plug 'vim-scripts/YankRing.vim' "TODO
Plug 'mileszs/ack.vim'
Plug 'vim-scripts/Auto-Pairs'
Plug 'jpalardy/vim-slime', { 'for': 'lisp' }
Plug 'mbbill/fencview'
Plug 'vim-scripts/Gundo' " TODO
" Plug 'vim-scripts/JSON.vim'
Plug 'vim-scripts/LargeFile'
Plug 'Lokaltog/vim-easymotion'
Plug 'vim-scripts/Mark'
Plug 'vim-scripts/Rename'
Plug 'vim-scripts/SingleCompile'
Plug 'vim-scripts/Tagbar', { 'on': 'TagbarToggle' }
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'Yggdroot/indentLine', { 'for': 'python' }
Plug 'vim-scripts/ZenCoding.vim', { 'for': 'html' }
Plug 'vim-scripts/a.vim', { 'for': ['c', 'cpp'] }
Plug 'vim-scripts/auto_mkdir'
Plug 'vim-scripts/ctrlp.vim' "TODO
Plug 'godlygeek/tabular'
" Plug 'hdima/python-syntax', { 'for': 'python' }
" Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
Plug 'junegunn/vim-easy-align'
Plug 'lightxue/SwissCalc'
Plug 'vim-scripts/matchit.zip'
" Plug 'vim-syntastic/syntastic' "TOD"
Plug 'vim-scripts/molokai'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'pthrasher/conqueterm-vim', { 'on': ['ConqueTermVSplit', 'ConqueTermTab'] }
" Plug 'vim-scripts/pydoc.vim', { 'for': 'python' }
Plug 'luochen1990/rainbow'
Plug 'sjas/csExplorer', { 'for': 'css' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'uarun/vim-protobuf', { 'for': 'protobuf' }
Plug 'sheerun/vim-polyglot' "多文件格式支持
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!']  }

call plug#end()
