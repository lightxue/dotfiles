local lang = {}

-- lang['fatih/vim-go'] = {
--     lazy = true,
--     ft = 'go',
--     build = ':GoInstallBinaries',
--     config = require('lang.vim-go'),
-- }
-- TODO
lang['iamcco/markdown-preview.nvim'] = {
    lazy = true,
    ft = 'markdown',
    build = ':call mkdp#util#install()',
}
lang['mechatroner/rainbow_csv'] = {
    lazy = true,
    ft = 'csv',
}
lang['folke/neodev.nvim'] = {
    lazy = true,
    ft = 'lua',
}
lang['rafcamlet/nvim-luapad'] = {
    lazy = true,
    ft = 'lua',
}
-- lang['MeanderingProgrammer/render-markdown.nvim'] = {
--     lazy = true,
--     ft = 'markdown',
--     opts = {},
--     dependencies = {
--         'nvim-tree/nvim-web-devicons',
--         'nvim-treesitter/nvim-treesitter',
--     },
-- }

return lang
