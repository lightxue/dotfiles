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

require'hop'.setup()
require('leap')
vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-forward-to)')
vim.keymap.set({'n', 'x', 'o'}, 'gS', '<Plug>(leap-backward-to)')
-- vim.keymap.set({'x', 'o'}, 'x', '<Plug>(leap-forward-till)')
-- vim.keymap.set({'x', 'o'}, 'X', '<Plug>(leap-backward-till)')
-- vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)')
-- vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-cross-window)')

-- require('flit').setup {
--   keys = { f = 'f', F = 'F', t = 't', T = 'T' },
--   -- A string like "nv", "nvo", "o", etc.
--   labeled_modes = "v",
--   multiline = false,
--   -- Like `leap`s similar argument (call-specific overrides).
--   -- E.g.: opts = { equivalence_classes = {} }
--   opts = {}
-- }

require('neoclip').setup()
require('telescope').load_extension('neoclip')

require('numb').setup()

-- vim.notify = require("notify")
