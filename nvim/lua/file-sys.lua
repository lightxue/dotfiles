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

