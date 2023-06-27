local tool = {}

tool['tpope/vim-fugitive'] = {
    lazy = true,
    cmd = { 'Git', 'G' },
}
-- TODO
-- Plug 'f-person/git-blame.nvim'
-- Plug 'junegunn/gv.vim'
-- only for fcitx5 user who uses non-English language during coding
-- tool["pysan3/fcitx5.nvim"] = {
-- 	lazy = true,
-- 	event = "BufReadPost",
-- 	cond = vim.fn.executable("fcitx5-remote") == 1,
-- 	config = require("tool.fcitx5"),
-- }
tool['nvim-neo-tree/neo-tree.nvim'] = {
    lazy = true,
    branch = 'v2.x',
    -- cmd = { 'Neotree', },
    event = 'VeryLazy',
    config = require('tool.neo-tree'),
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-tree/nvim-web-devicons' },
        { 'MunifTanjim/nui.nvim' },
    },
}
-- TODO 是否添加
tool['ibhagwan/smartyank.nvim'] = {
    lazy = true,
    event = 'BufReadPost',
    config = require('tool.smartyank'),
}
tool['michaelb/sniprun'] = {
    lazy = true,
    -- You need to cd to `~/.local/share/nvim/site/lazy/sniprun/` and execute `bash ./install.sh`,
    -- if you encountered error about no executable sniprun found.
    build = 'bash ./install.sh',
    cmd = { 'SnipRun' },
    config = require('tool.sniprun'),
}
tool['akinsho/toggleterm.nvim'] = {
    lazy = true,
    cmd = {
        'ToggleTerm',
        'ToggleTermSetName',
        'ToggleTermToggleAll',
        'ToggleTermSendVisualLines',
        'ToggleTermSendCurrentLine',
        'ToggleTermSendVisualSelection',
    },
    config = require('tool.toggleterm'),
}
tool['folke/trouble.nvim'] = {
    lazy = true,
    cmd = { 'Trouble', 'TroubleToggle', 'TroubleRefresh' },
    config = require('tool.trouble'),
}
tool['folke/which-key.nvim'] = {
    lazy = true,
    event = { 'CursorHold', 'CursorHoldI' },
    config = require('tool.which-key'),
}
-- TODO 是否添加
tool['gelguy/wilder.nvim'] = {
    lazy = true,
    event = 'CmdlineEnter',
    config = require('tool.wilder'),
    dependencies = { 'romgrk/fzy-lua-native' },
}
tool['lightxue/SwissCalc'] = {
    lazy = true,
    cmd = { 'Scalc' },
}

-- TODO
-- Plug 'NTBBloodbath/rest.nvim'

----------------------------------------------------------------------
--                        Telescope Plugins                         --
----------------------------------------------------------------------
tool['nvim-telescope/telescope.nvim'] = {
    lazy = true,
    cmd = 'Telescope',
    config = require('tool.telescope'),
    dependencies = {
        { 'nvim-tree/nvim-web-devicons' },
        { 'nvim-lua/plenary.nvim' },
        { 'debugloop/telescope-undo.nvim' },
        {
            'ahmedkhalf/project.nvim',
            event = 'BufReadPost',
            config = require('tool.project'),
        },
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        { 'nvim-telescope/telescope-frecency.nvim', dependencies = {
            { 'kkharji/sqlite.lua' },
        } },
        -- TODO
        -- {
        --           "AckslD/nvim-neoclip.lua",
        --           dependencies = {
        --               { "kkharji/sqlite.lua" },
        --       }
        --       },
        { 'jvgrootveld/telescope-zoxide' },
        { 'nvim-telescope/telescope-live-grep-args.nvim' },
    },
}

----------------------------------------------------------------------
--                           DAP Plugins                            --
----------------------------------------------------------------------
tool['mfussenegger/nvim-dap'] = {
    lazy = true,
    cmd = {
        'DapSetLogLevel',
        'DapShowLog',
        'DapContinue',
        'DapToggleBreakpoint',
        'DapToggleRepl',
        'DapStepOver',
        'DapStepInto',
        'DapStepOut',
        'DapTerminate',
    },
    config = require('tool.dap'),
    dependencies = {
        {
            'rcarriga/nvim-dap-ui',
            config = require('tool.dap.dapui'),
        },
        { 'jay-babu/mason-nvim-dap.nvim' },
        { 'theHamsta/nvim-dap-virtual-text' },
        { 'nvim-telescope/telescope-dap.nvim' },
        -- { "mfussenegger/nvim-dap-python" },
        -- { "leoluz/nvim-dap-go" },
        -- { "mxsdev/nvim-dap-vscode-js" },
        -- { "jbyuki/one-small-step-for-vimkind" },
    },
}

return tool
