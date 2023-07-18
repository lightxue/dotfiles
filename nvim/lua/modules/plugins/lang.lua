local lang = {}

-- lang['fatih/vim-go'] = {
--     lazy = true,
--     ft = 'go',
--     build = ':GoInstallBinaries',
--     config = require('lang.vim-go'),
-- }
-- TODO
-- lang['iamcco/markdown-preview.nvim'] = {
--     lazy = true,
--     ft = 'markdown',
--     build = ':call mkdp#util#install()',
--     -- config = require('lang.markdown-preview'),
-- }
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

return lang
