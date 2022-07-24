local navic = require("nvim-navic")
navic.setup({
    separator = " → ",
})

require('lualine').setup({
    options = {
        component_separators = { left = '', right = '|' },
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diagnostics' },
        lualine_c = {
            { 'filename', path = 1 },
            { navic.get_location, cond = navic.is_available }
        },
        lualine_x = {
            { 'filetype', icon = { align = 'right' } },
            'encoding',
            'fileformat'
        },
        lualine_y = { '%l/%L:%c' },
        lualine_z = { '%b-0x%B' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = {
            { 'filetype', icon = { align = 'right' } },
            'encoding',
            'fileformat'
        },
        lualine_y = { '%l/%L:%c' },
        lualine_z = {}
    },
})

