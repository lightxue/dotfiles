local M = {}

local function alpha_reset()
    -- local startify = require'alpha.themes.startify'
    local dashboard = require'alpha.themes.dashboard'
    dashboard.section.header.val = require('fortune')()
    require'alpha'.setup(dashboard.opts)
end

function M.setup()
    vim.api.nvim_create_user_command('Startify', function()
        alpha_reset()
        require'alpha'.start(false)
    end, {
        bang = true,
        desc = 'require"alpha".start(false)',
    })
    alpha_reset()
end

return M
