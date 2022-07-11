-- insert = "ys",
-- visual = "S",
-- delete = "ds",
-- change = "cs",
require("nvim-surround").setup({})

-- require("indent_blankline").setup {
--     -- for example, context is off by default, use this to turn it on
--     show_current_context = true,
--     show_current_context_start = true,
-- }

require("which-key").setup()
require('neoscroll').setup()
require('lualine').setup({
    options = {
        component_separators = '',
        section_separators = '',
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diagnostics' },
        lualine_c = { { 'filename', path = 1 } },
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
