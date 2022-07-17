require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
        { key = "C", action = "cd" },
        { key = "s", action = "vsplit" },
        { key = "O", action = "system_open" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})

require("toggleterm").setup({
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.5
    end
  end,
  direction = 'float'
})
vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm<CR>', { noremap = true })
vim.keymap.set('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical <CR>', { noremap = true })
vim.keymap.set('n', '<leader>tf', '<cmd>ToggleTerm direction=float<CR>', { noremap = true })
vim.keymap.set('n', '<leader>th', '<cmd>ToggleTerm direction=horizontal<CR>', { noremap = true })
vim.keymap.set('n', '<leader>ts', '<cmd>ToggleTermSendCurrentLine<CR>', { noremap = true })
vim.keymap.set('v', '<leader>ts', '<cmd>ToggleTermSendVisualSelection<CR>', { noremap = true })

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
