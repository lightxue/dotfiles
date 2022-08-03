local M = {}

local function init_theme()
    local dashboard = require'alpha.themes.dashboard'
    local btn = dashboard.button
    dashboard.section.header.val = require('fortune')()
    dashboard.section.buttons.val = {
        btn("e", "  New file",     "<Cmd>ene <CR>"),
        btn("s", "  Scratch",      "<Cmd>Scratch<CR>"),
        btn("f", "  Find file",    "<Cmd>Telescope find_files<CR>"),
        btn("m", "  Frecency/MRU", "<Cmd>Telescope oldfiles<CR>"),
        btn("p", "  Find project", "<Cmd>Telescope projects<CR>"),
        btn("b", "  Find buffer",  "<Cmd>Telescope buffers<CR>"),
        btn("g", "  Find word",    "<Cmd>Telescope live_grep<CR>"),
    }
    dashboard.section.footer.val = [[
Vim is a way of life
  🄻 🄸 🄶 🄷 🅃  🅇 🅄 🄴
    ]]
    return dashboard
end

local function reset_theme(theme)
    theme.section.header.val = require('fortune')()
    require'alpha'.setup(theme.opts)
end

function M.setup()
    local theme = init_theme()
    vim.api.nvim_create_user_command('Startify', function()
        reset_theme(theme)
        require'alpha'.start(false)
    end, {
        bang = true,
        desc = 'require"alpha".start(false)',
    })
    reset_theme(theme)
end

return M
