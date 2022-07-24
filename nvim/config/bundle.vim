let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.config/nvim/bundle')

" 补全
Plug 'windwp/nvim-autopairs'
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig' " Collection of configurations for built-in LSP client
Plug 'hrsh7th/nvim-cmp' " Autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp
Plug 'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
Plug 'L3MON4D3/LuaSnip' " Snippets plugin
Plug 'rafamadriz/friendly-snippets' " vscode snippet
Plug 'hrsh7th/cmp-buffer'
Plug 'uga-rosa/cmp-dictionary'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'dmitmel/cmp-cmdline-history'
Plug 'tamago324/cmp-zsh'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'onsails/lspkind.nvim'
Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }

" 语言
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'liuchengxu/vista.vim'
Plug 'vim-scripts/a.vim', { 'for': ['c', 'cpp'] }
Plug 'xuhdev/SingleCompile'
Plug 'p00f/nvim-ts-rainbow'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'norcalli/nvim-colorizer.lua'
Plug 'numToStr/Comment.nvim'
Plug 'max397574/lua-dev.nvim'
Plug 'windwp/nvim-ts-autotag'
Plug 'haringsrob/nvim_context_vt'

" 文本操作
Plug 'ConradIrwin/vim-bracketed-paste' " 插入模式C-V自动set paste
Plug 'phaazon/hop.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'andymass/vim-matchup'
Plug 'junegunn/vim-easy-align'
Plug 'lfv89/vim-interestingwords'
Plug 'mg979/vim-visual-multi'
Plug 'thinca/vim-visualstar'
Plug 'tpope/vim-repeat'
Plug 'kylechui/nvim-surround'
Plug 'RRethy/vim-illuminate'
Plug 'NMAC427/guess-indent.nvim'
Plug 'monaqa/dial.nvim'

" 编辑器设置
Plug 'folke/which-key.nvim'
Plug 'mbbill/fencview'
Plug 'mbbill/undotree'
" Plug 'simnalamburt/vim-mundo'
Plug 'mhinz/vim-startify'
Plug 'vim-scripts/scratch.vim'
Plug 'karb94/neoscroll.nvim'
Plug 'jdhao/better-escape.vim'
Plug 'rcarriga/nvim-notify'
Plug 'AckslD/nvim-neoclip.lua'
Plug 'nacro90/numb.nvim'

"文件/系统
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'ahmedkhalf/project.nvim'
Plug 'tpope/vim-fugitive'
Plug 'f-person/git-blame.nvim'
Plug 'junegunn/gv.vim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'vim-scripts/Rename'
Plug 'vim-scripts/auto_mkdir'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'PhilRunninger/nerdtree-visual-selection'
" Plug 'kyazdani42/nvim-tree.lua'  " 还有些bug，比如:e .时消失，或是跳到别的标
" 签页
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/toggleterm.nvim', {'tag' : 'v2.*'}

" UI
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'nvim-lualine/lualine.nvim'
Plug 'SmiteshP/nvim-navic'

" 其它
Plug 'lightxue/SwissCalc'
Plug 'NTBBloodbath/rest.nvim'

call plug#end()

" TODO
" vim-visual-multi
" mfussenegger/nvim-dap
" "Pocco81/dap-buddy.nvim"
