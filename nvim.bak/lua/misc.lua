require("rest-nvim").setup({
    -- Open request results in a horizontal split
    result_split_horizontal = false,
    -- Keep the http file buffer above|left when split horizontal|vertical
    result_split_in_place = false,
    -- Skip SSL verification, useful for unknown certificates
    skip_ssl_verification = true,
    -- Highlight request on run
    highlight = {
        enabled = true,
        timeout = 150,
    },
    -- Jump to request line on run
    jump_to_request = false,
    env_file = '.env',
    yank_dry_run = true,
})
vim.keymap.set('n', '<leader>ht', '<Plug>RestNvim<CR>', { noremap = true })
vim.keymap.set('n', '<leader>hp', '<Plug>RestNvimPreview<CR>', { noremap = true })
