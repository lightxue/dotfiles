local completion = {}

completion['neovim/nvim-lspconfig'] = {
    lazy = true,
    event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
    config = require('completion.lsp'),
    dependencies = {
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
        {
            'ray-x/lsp_signature.nvim',
            config = require('completion.lsp-signature'),
        },
    },
}
completion['nvimdev/lspsaga.nvim'] = {
    lazy = true,
    event = 'LspAttach',
    config = require('completion.lspsaga'),
    dependencies = { 'nvim-tree/nvim-web-devicons' },
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
        { 'lukas-reineke/cmp-under-comparator' },
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
        { 'ray-x/cmp-treesitter', commit = 'c8e3a74' },
        -- {
        -- 	"jcdickinson/codeium.nvim",
        --     -- 鉴权报错 https://github.com/jcdickinson/codeium.nvim/issues/70
        --     -- 待修复 https://github.com/jcdickinson/codeium.nvim/pull/74
        --     commit = "b1ff0d6c993e3d87a4362d2ccd6c660f7444599f",
        -- 	dependencies = {
        -- 		"nvim-lua/plenary.nvim",
        -- 	},
        --     config = function()
        --         require('codeium').setup({})
        --     end,
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
            config = function()
                require('copilot_cmp').setup({})
            end,
        },
    },
}

return completion
