require('nvim-treesitter.configs').setup {
  ensure_installed = "all",
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    lsp_interop = {
      enable = true,
      border = 'none',
      peek_definition_code = {
        -- ["<leader>dd"] = "@function.outer",
        -- ["<leader>dD"] = "@class.outer",
      },
    },
  },
  rainbow = {
    enable = true,
    -- list of languages you want to disable the plugin for
    -- disable = { 'jsx', 'cpp' },
    -- Which query to use for finding delimiters
    query = 'rainbow-parens',
    -- Highlight the entire buffer all at once
    strategy = require('ts-rainbow').strategy.global,
  }
}

require 'colorizer'.setup {
    'css';
    'javascript';
    html = {
        mode = 'foreground';
    }
}

require("indent_blankline").setup {
    show_trailing_blankline_indent = false,
    filetype = {
        'python',
        'yaml',
        'javascript',
        'lua',
        'json',
    },
}

require('Comment').setup()

require('nvim-ts-autotag').setup()
require('nvim_context_vt').setup({
  enabled = false,
})

require('luapad').setup {
  count_limit = 150000,
  error_indicator = false,
  eval_on_move = true,
  error_highlight = 'WarningMsg',
  split_orientation = 'horizontal',
  on_init = function()
    print 'Hello from Luapad!'
  end,
  context = {
    the_answer = 42,
    shout = function(str) return(string.upper(str) .. '!') end
  }
}

require('nvim_context_vt').setup({
  -- Enable by default. You can disable and use :NvimContextVtToggle to maually enable.
  -- Default: true
  enabled = true,

  -- Override default virtual text prefix
  -- Default: '-->'
  -- prefix = '',

  -- Override the internal highlight group name
  -- Default: 'ContextVt'
  -- highlight = 'CustomContextVt',

  -- Disable virtual text for given filetypes
  -- Default: { 'markdown' }
  disable_ft = { 'markdown' },

  -- Disable display of virtual text below blocks for indentation based languages like Python
  -- Default: false
  -- disable_virtual_lines = false,

  -- Same as above but only for spesific filetypes
  -- Default: {}
  disable_virtual_lines_ft = { 'yaml' },
})
