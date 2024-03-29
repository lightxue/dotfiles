let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.config/nvim/bundle')

" 补全
Plug 'windwp/nvim-autopairs' " TODO m4xshen/autoclose.nvim
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig' " Collection of configurations for built-in LSP client
Plug 'hrsh7th/nvim-cmp' " Autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp
Plug 'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
" Snippets plugin
" follow latest release and install jsregexp.
Plug 'L3MON4D3/LuaSnip', {'tag': 'v1.*'}
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
Plug 'jose-elias-alvarez/null-ls.nvim'

" 语言
let nproc = system('nproc')
if nproc > 4
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
else
    Plug 'nvim-treesitter/nvim-treesitter'
endif
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'liuchengxu/vista.vim' " TODO
Plug 'vim-scripts/a.vim', { 'for': ['c', 'cpp'] }
Plug 'HiPhish/nvim-ts-rainbow2'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'norcalli/nvim-colorizer.lua'
Plug 'numToStr/Comment.nvim'
Plug 'max397574/lua-dev.nvim'
Plug 'windwp/nvim-ts-autotag'
Plug 'haringsrob/nvim_context_vt'
Plug 'rafcamlet/nvim-luapad'
Plug 'mechatroner/rainbow_csv'

" debugger
Plug 'mfussenegger/nvim-dap'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'rcarriga/nvim-dap-ui'
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'mfussenegger/nvim-dap-python'
Plug 'leoluz/nvim-dap-go'
Plug 'mxsdev/nvim-dap-vscode-js'
Plug 'jbyuki/one-small-step-for-vimkind'

" 文本操作
Plug 'ConradIrwin/vim-bracketed-paste' " 插入模式C-V自动set paste TODO
Plug 'phaazon/hop.nvim'
Plug 'ggandor/leap.nvim'
" Plug 'ggandor/flit.nvim'
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
Plug 'vim-scripts/scratch.vim'
Plug 'karb94/neoscroll.nvim'
Plug 'jdhao/better-escape.vim'
Plug 'rcarriga/nvim-notify'
Plug 'AckslD/nvim-neoclip.lua'
Plug 'nacro90/numb.nvim'
Plug 'LunarVim/bigfile.nvim'
Plug 'lambdalisue/suda.vim'

"文件/系统
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'ahmedkhalf/project.nvim'
Plug 'tpope/vim-fugitive'
Plug 'f-person/git-blame.nvim'
Plug 'junegunn/gv.vim'
Plug 'lewis6991/gitsigns.nvim'
" Plug 'vim-scripts/Rename'
" Plug 'vim-scripts/auto_mkdir'
" Plug 'ryanoasis/vim-devicons'
" Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-neo-tree/neo-tree.nvim', { 'branch': 'v2.x' }

Plug 'nvim-tree/nvim-web-devicons'
Plug 'MunifTanjim/nui.nvim'
" 签页
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

" UI
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'nvim-lualine/lualine.nvim'
Plug 'SmiteshP/nvim-navic'
Plug 'goolord/alpha-nvim'

" 其它
Plug 'lightxue/SwissCalc'
Plug 'NTBBloodbath/rest.nvim'

call plug#end()

" TODO
" vim-visual-multi
