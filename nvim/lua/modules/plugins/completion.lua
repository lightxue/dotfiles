local completion = {}

completion['neovim/nvim-lspconfig'] = {
    lazy = true,
    event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
    config = require('completion.lsp'),
    dependencies = {
        { 'ray-x/lsp_signature.nvim' }, -- TODO
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
        {
            'nvimdev/lspsaga.nvim',
            config = require('completion.lspsaga'),
        },
    },
}
completion['jose-elias-alvarez/null-ls.nvim'] = {
    lazy = true,
    event = { 'CursorHold', 'CursorHoldI' },
    config = require('completion.null-ls'),
    dependencies = {
        'nvim-lua/plenary.nvim',
        'jay-babu/mason-null-ls.nvim',
    },
}
completion['hrsh7th/nvim-cmp'] = {
    lazy = true,
    event = 'InsertEnter',
    config = require('completion.cmp'),
    dependencies = {
        {
            'L3MON4D3/LuaSnip',
            dependencies = { 'rafamadriz/friendly-snippets' },
            config = require('completion.luasnip'),
        },
        { 'lukas-reineke/cmp-under-comparator' }, -- TODO 是否添加？
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-cmdline' },
        { 'dmitmel/cmp-cmdline-history' },
        { 'tamago324/cmp-zsh' },
        { 'andersevenrud/cmp-tmux' },
        { 'hrsh7th/cmp-path' },
        { 'f3fora/cmp-spell' },
        { 'uga-rosa/cmp-dictionary' },
        -- { "kdheepak/cmp-latex-symbols" },
        { 'ray-x/cmp-treesitter', commit = 'c8e3a74' }, -- TODO 是否添加？
        -- { "tzachar/cmp-tabnine", build = "./install.sh", config = require("completion.tabnine") },
        -- {
        -- 	"jcdickinson/codeium.nvim",
        -- 	dependencies = {
        -- 		"nvim-lua/plenary.nvim",
        -- 		"MunifTanjim/nui.nvim",
        -- 	},
        -- 	config = require("completion.codeium"),
        -- },
    },
}
completion['zbirenbaum/copilot.lua'] = {
    lazy = true,
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = require('completion.copilot'),
    dependencies = {
        {
            'zbirenbaum/copilot-cmp',
            config = require('completion.copilot-cmp'),
        },
    },
}

return completion
