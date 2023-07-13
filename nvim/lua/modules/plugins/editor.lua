local editor = {}

editor['rainbowhxch/accelerated-jk.nvim'] = {
    lazy = true,
    event = 'VeryLazy',
    config = require('editor.accelerated-jk'),
}
editor['m4xshen/autoclose.nvim'] = {
    lazy = true,
    event = 'InsertEnter',
    config = require('editor.autoclose'),
}
editor['max397574/better-escape.nvim'] = {
    lazy = true,
    event = { 'CursorHold', 'CursorHoldI' },
    config = require('editor.better-escape'),
}
editor['LunarVim/bigfile.nvim'] = {
    lazy = false,
    config = require('editor.bigfile'),
    cond = require('core.settings').load_big_files_faster,
}

editor['rhysd/clever-f.vim'] = {
    lazy = true,
    event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
    config = require('editor.cleverf'),
}
editor['numToStr/Comment.nvim'] = {
    lazy = true,
    event = { 'CursorHold', 'CursorHoldI' },
    config = require('editor.comment'),
}
editor['sindrets/diffview.nvim'] = {
    lazy = true,
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
}
editor['junegunn/vim-easy-align'] = {
    lazy = true,
    cmd = 'EasyAlign',
}
editor['phaazon/hop.nvim'] = {
    lazy = true,
    branch = 'v2',
    event = 'BufReadPost',
    config = require('editor.hop'),
}
editor['RRethy/vim-illuminate'] = {
    lazy = true,
    event = { 'CursorHold', 'CursorHoldI' },
    config = require('editor.vim-illuminate'),
}
-- 搜索后自动取消高亮
editor['romainl/vim-cool'] = {
    lazy = true,
    event = { 'CursorMoved', 'InsertEnter' },
}
editor['lambdalisue/suda.vim'] = {
    lazy = true,
    cmd = { 'SudaRead', 'SudaWrite' },
    config = require('editor.suda'),
}
editor['nmac427/guess-indent.nvim'] = {
    lazy = true,
    event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
    opts = {},
}
editor['tpope/vim-repeat'] = {
    lazy = true,
    event = 'VeryLazy',
}
editor['kylechui/nvim-surround'] = {
    event = 'VeryLazy',
    opts = {},
}
editor['mbbill/fencview'] = {
    lazy = true,
    cmd = { 'FencView', 'FencAutoDetect', 'FencManualEncoding' },
    config = require('editor.suda'),
}
-- TODO
-- Mr-LLLLL/interestingwords.nvim TODO
-- Plug 'thinca/vim-visualstar'
-- Plug 'monaqa/dial.nvim'
-- https://github.com/LintaoAmons/scratch.nvim

----------------------------------------------------------------------
--                  :treesitter related plugins                    --
----------------------------------------------------------------------
editor['nvim-treesitter/nvim-treesitter'] = {
    lazy = true,
    build = function()
        if #vim.api.nvim_list_uis() ~= 0 then
            vim.api.nvim_command('TSUpdate')
        end
    end,
    event = { 'CursorHold', 'CursorHoldI' },
    config = require('editor.treesitter'),
    dependencies = {
        { 'nvim-treesitter/nvim-treesitter-textobjects' },
        {
            'nvim-treesitter/nvim-treesitter-context',
            config = require('editor.ts-context'),
        },
        { 'HiPhish/nvim-ts-rainbow2' },
        { 'JoosepAlviste/nvim-ts-context-commentstring' },
        { 'mfussenegger/nvim-treehopper' },
        { 'andymass/vim-matchup' },
        {
            'windwp/nvim-ts-autotag',
            config = require('editor.autotag'),
        },
        {
            'NvChad/nvim-colorizer.lua',
            config = require('editor.colorizer'),
        },
    },
}

return editor
