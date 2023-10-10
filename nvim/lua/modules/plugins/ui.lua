local ui = {}
ui['folke/tokyonight.nvim'] = {
    lazy = true,
    config = require('ui.tokyonight'),
}
ui['goolord/alpha-nvim'] = {
    lazy = true,
    event = 'BufWinEnter',
    config = require('ui.alpha'),
}
ui['j-hui/fidget.nvim'] = {
    lazy = true,
    branch = 'legacy',
    event = 'LspAttach',
    config = require('ui.fidget'),
}
ui['lewis6991/gitsigns.nvim'] = {
    lazy = true,
    event = { 'CursorHold', 'CursorHoldI' },
    config = require('ui.gitsigns'),
}
ui['lukas-reineke/indent-blankline.nvim'] = {
    lazy = true,
    event = 'BufReadPost',
    main = 'ibl',
    opts = {},
    -- config = require('ui.indent-blankline'),
}
ui['nvim-lualine/lualine.nvim'] = {
    lazy = true,
    event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
    config = require('ui.lualine'),
}
ui['zbirenbaum/neodim'] = {
    lazy = true,
    event = 'LspAttach',
    config = require('ui.neodim'),
}
-- ui['karb94/neoscroll.nvim'] = {
--     lazy = true,
--     event = 'BufReadPost',
--     config = require('ui.neoscroll'),
-- }
-- ui["shaunsingh/nord.nvim"] = {
-- 	lazy = true,
-- 	config = require("ui.nord"),
-- }
ui['rcarriga/nvim-notify'] = {
    lazy = true,
    event = 'VeryLazy',
    config = require('ui.notify'),
}
ui['folke/paint.nvim'] = {
    lazy = true,
    event = { 'CursorHold', 'CursorHoldI' },
    config = require('ui.paint'),
}

return ui
