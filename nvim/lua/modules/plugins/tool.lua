local tool = {}

tool['tpope/vim-fugitive'] = {
    lazy = true,
    cmd = { 'Git', 'G', 'Gllog', 'Gvdiffsplit' },
}

tool['junegunn/gv.vim'] = {
    lazy = true,
    cmd = { 'GV' },
    dependencies = {
        'tpope/vim-fugitive',
    },
}

tool['nvim-neo-tree/neo-tree.nvim'] = {
    lazy = true,
    branch = 'v3.x',
    event = 'VeryLazy',
    config = require('tool.neo-tree'),
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-tree/nvim-web-devicons' },
        { 'MunifTanjim/nui.nvim' },
    },
}
-- 可通过SSH复制到剪贴板，并高亮复制内容
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
-- TODO 熟悉使用
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
-- tool['ybian/smartim'] = {
--     lazy = true,
--     event = 'InsertEnter',
--     config = require('tool.smartim'),
-- }

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
        {
            'nvim-telescope/telescope-frecency.nvim',
            dependencies = {
                { 'kkharji/sqlite.lua' },
            },
        },
        {
            'AckslD/nvim-neoclip.lua',
            opts = {},
            dependencies = {
                { 'kkharji/sqlite.lua' },
            },
        },
        { 'jvgrootveld/telescope-zoxide' },
        { 'nvim-telescope/telescope-live-grep-args.nvim' },
    },
}

----------------------------------------------------------------------
--                           DAP Plugins                            --
----------------------------------------------------------------------
-- tool['mfussenegger/nvim-dap'] = {
--     lazy = true,
--     cmd = {
--         'DapSetLogLevel',
--         'DapShowLog',
--         'DapContinue',
--         'DapToggleBreakpoint',
--         'DapToggleRepl',
--         'DapStepOver',
--         'DapStepInto',
--         'DapStepOut',
--         'DapTerminate',
--     },
--     config = require('tool.dap'),
--     dependencies = {
--         {
--             'rcarriga/nvim-dap-ui',
--             config = require('tool.dap.dapui'),
--         },
--         { 'jay-babu/mason-nvim-dap.nvim' },
--         { 'theHamsta/nvim-dap-virtual-text' },
--         { 'nvim-telescope/telescope-dap.nvim' },
--     },
-- }

return tool
