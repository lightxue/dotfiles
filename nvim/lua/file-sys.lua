-- require("nvim-tree").setup({
--   sort_by = "case_sensitive",
--   view = {
--     mappings = {
--       list = {
--         { key = "u", action = "dir_up" },
--         { key = "C", action = "cd" },
--         { key = "s", action = "vsplit" },
--         { key = "O", action = "system_open" },
--       },
--     },
--   },
--   renderer = {
--     group_empty = true,
--   },
--   filters = {
--     dotfiles = false,
--   },
-- })

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

require('telescope').setup {}
require('telescope').load_extension('fzf')

require("project_nvim").setup({
    silent_chdir = false,
})
require('telescope').load_extension('projects')

require('gitsigns').setup()


--------------------------------------------------------------------------------
-- ToogleTerm
--------------------------------------------------------------------------------

local function get_shebang_cmd()
    local shebang_head = '#!'
    local lines = vim.api.nvim_buf_get_lines(0, 0, 1, true)
    local first_line = #lines > 0 and lines[1] or ''
    if first_line:find(shebang_head, 1, true) == 1 then
        return first_line:sub(#shebang_head + 1)
    end
    return nil
end

local ft_cmd = {
    python = 'python3',
    lua = 'lua',
    javascript = 'node',
    go = 'go run',
    sh = 'bash',
    c = 'gcc',  -- TODO 需要编译且运行
    cpp = 'g++'  -- TODO
}
local function get_filetype_cmd()
    return ft_cmd[vim.bo.filetype]
end

local function run_current_file()
    local fn = vim.fn.expand('%:p')
    local cmd = get_shebang_cmd() or get_filetype_cmd()
    if cmd == nil then
        vim.notify('Not proper command to run current file', 'error')
        return
    elseif fn == nil or fn == '' then
        vim.notify('Invalid file path to run', 'error')
        return
    end
    require("toggleterm").exec(cmd .. ' ' .. fn)
end

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
local kmopts = { noremap = true }
vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm<CR>', kmopts)
vim.keymap.set('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical <CR>', kmopts)
vim.keymap.set('n', '<leader>tf', '<cmd>ToggleTerm direction=float<CR>', kmopts)
vim.keymap.set('n', '<leader>th', '<cmd>ToggleTerm direction=horizontal<CR>', kmopts)
vim.keymap.set('n', '<leader>ts', '<cmd>ToggleTermSendCurrentLine<CR>', kmopts)
vim.keymap.set('v', '<leader>ts', '<cmd>ToggleTermSendVisualSelection<CR>', kmopts)
vim.keymap.set('n', '<leader>tr', run_current_file, kmopts)
vim.keymap.set('n', '<leader>tl', "<cmd>TermExec cmd='r'<CR>", kmopts) -- run last command in zsh
-- https://github.com/sbdchd/vim-run
