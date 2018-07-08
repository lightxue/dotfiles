filetype off       " 必须保留，不能删掉

"let &rtp=&rtp.','.g:_vimfiles.'/bundle/vundle'
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" 必须保留，不能删掉
Plugin 'VundleVim/Vundle.vim'

"补全
if has('win32')
    Plugin 'Shougo/neocomplcache'
    "Plugin 'Shougo/neosnippet'
else
    Plugin 'Valloric/YouCompleteMe'
endif

"Plugin 'Align'
"Plugin 'AuthorInfo'
"Plugin 'DoxygenToolkit.vim'
"Plugin 'DrawIt'
"Plugin 'TeTrIs.vim'
"Plugin 'VOoM'
"Plugin 'VimPdb'
"Plugin 'altercation/vim-colors-solarized'
"Plugin 'asins/vimcdoc'
"Plugin 'bufexplorer.zip'
"Plugin 'minibufexpl.vim'
"Plugin 'Shougo/unite.vim'
Plugin 'romainl/Apprentice'
Plugin 'posva/vim-vue'
Plugin 'ConradIrwin/vim-bracketed-paste'
Plugin 'Chiel92/vim-autoformat'
Plugin 'scratch.vim'
Plugin 'tpope/vim-repeat'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'YankRing.vim'
Plugin 'mileszs/ack.vim'
Plugin 'Auto-Pairs'
Plugin 'jpalardy/vim-slime'
Plugin 'mbbill/fencview'
Plugin 'Gundo'
Plugin 'JSON.vim'
Plugin 'LargeFile'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'Mark'
"Plugin 'Pydiction'
Plugin 'Rename'
Plugin 'SearchComplete'
Plugin 'SingleCompile'
Plugin 'SirVer/ultisnips'
Plugin 'Tagbar'
Plugin 'The-NERD-Commenter'
Plugin 'The-NERD-tree'
"Plugin 'VimRepress'
"Plugin 'VisIncr'
Plugin 'Yggdroot/indentLine'
Plugin 'ZenCoding.vim'
Plugin 'a.vim'
Plugin 'auto_mkdir'
Plugin 'blackboard.vim'
Plugin 'calendar.vim--Matsumoto'
Plugin 'ctrlp.vim'
Plugin 'godlygeek/tabular'
Plugin 'hdima/python-syntax'
Plugin 'hynek/vim-python-pep8-indent'
"Plugin 'indentpython'
Plugin 'junegunn/vim-easy-align'
Plugin 'lightxue/SwissCalc'
Plugin 'matchit.zip'
Plugin 'vim-syntastic/syntastic'
"Plugin 'matrix.vim--Yang'
Plugin 'mmai/wikilink'
"Plugin 'molokai'
Plugin 'mru.vim'
Plugin 'plasticboy/vim-markdown'
Plugin 'pthrasher/conqueterm-vim'
Plugin 'pydoc.vim'
"Plugin 'rainbow_parentheses.vim'
"Plugin 'oblitum/rainbow'
Plugin 'luochen1990/rainbow'
Plugin 'sjas/csExplorer'
Plugin 'taglist.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'uarun/vim-protobuf'
Plugin 'vcscommand.vim'
Plugin 'sheerun/vim-polyglot'
"Plugin 'marijnh/tern_for_vim'
Plugin 'benmills/vimux'
"Plugin 'vimwiki'
"Plugin 'airblade/vim-rooter'
Plugin 'airblade/vim-gitgutter'
"Plugin 'wlangstroth/vim-racket'


filetype plugin indent on     " 恢复filetype设置

