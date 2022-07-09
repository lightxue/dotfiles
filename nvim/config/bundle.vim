
source ~/.config/nvim/bundle/vim-plug/plug.vim
call plug#begin('~/.config/nvim/bundle')

" 补全
" Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'honza/vim-snippets'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig' " Collection of configurations for built-in LSP client
Plug 'hrsh7th/nvim-cmp' " Autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp
Plug 'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
Plug 'L3MON4D3/LuaSnip' " Snippets plugin
Plug 'hrsh7th/cmp-buffer'
Plug 'uga-rosa/cmp-dictionary' " TODO 添加词典
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'dmitmel/cmp-cmdline-history'
Plug 'tamago324/cmp-zsh'
Plug 'hrsh7th/cmp-nvim-lua'

" 语言
Plug 'Yggdroot/indentLine'
" Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'luochen1990/rainbow'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot' "多文件格式支持
" Plug 'vim-scripts/Tagbar', { 'on': 'TagbarToggle' }
Plug 'liuchengxu/vista.vim'
Plug 'vim-scripts/a.vim', { 'for': ['c', 'cpp'] }
Plug 'xuhdev/SingleCompile'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" 文本操作
Plug 'ConradIrwin/vim-bracketed-paste' " 插入模式C-V自动set paste
Plug 'Lokaltog/vim-easymotion'
" Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'andymass/vim-matchup'
Plug 'junegunn/vim-easy-align'
Plug 'lfv89/vim-interestingwords'
Plug 'mg979/vim-visual-multi'
Plug 'thinca/vim-visualstar'
Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-surround'
Plug 'kylechui/nvim-surround'

" 编辑器设置
Plug 'liuchengxu/vim-which-key'
Plug 'mbbill/fencview'
Plug 'mbbill/undotree'
" Plug 'simnalamburt/vim-mundo'
Plug 'mhinz/vim-startify'
Plug 'vim-scripts/scratch.vim'
Plug 'karb94/neoscroll.nvim'
Plug 'jdhao/better-escape.vim'
Plug 'rcarriga/nvim-notify'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

"文件/系统
" Plug 'pthrasher/conqueterm-vim', { 'on': ['ConqueTermVSplit', 'ConqueTermTab'] }
" Plug 'sillybun/vim-repl'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-fugitive'
Plug 'f-person/git-blame.nvim'
Plug 'junegunn/gv.vim'
Plug 'vim-scripts/Rename'
Plug 'vim-scripts/auto_mkdir'
" Plug 'mcchrish/nnn.vim'
Plug 'scrooloose/nerdtree'
Plug 'kyazdani42/nvim-web-devicons' " optional, for file icons
Plug 'kyazdani42/nvim-tree.lua'

" 其它
Plug 'flazz/vim-colorschemes'
Plug 'lightxue/SwissCalc'

call plug#end()

" TODO
" snippets
" nerd tree failed
" vim-visual-multi

" :CocInstall coc-marketplace coc-json coc-tsserver coc-html coc-css coc-vetur coc-yaml
" :CocInstall coc-python coc-highlight coc-snippets coc-git coc-yank coc-vimlsp coc-emoji
" :CocInstall coc-word coc-sql coc-ecdict coc-go coc-lua
