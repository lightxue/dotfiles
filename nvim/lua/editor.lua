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

require('neoclip').setup()
require('telescope').load_extension('neoclip')

require('numb').setup()

-- vim.notify = require("notify")
