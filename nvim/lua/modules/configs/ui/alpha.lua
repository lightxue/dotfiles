local function footer()
    -- local slogan = {
    --     '         Vim is a way of life',
    --     '           🄻 🄸 🄶 🄷 🅃  🅇 🅄 🄴',
    --     ' Neovim 󰀨 v0.9.0 󰂖 93 plugins in 57ms', -- 示例调位置
    -- }
    -- local stats = require('lazy').stats()
    -- local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    -- slogan[3] = string.format(
    --     ' Neovim 󰀨 v%d.%d.%d 󰂖 %2d plugins in %2dms',
    --     vim.version().major,
    --     vim.version().minor,
    --     vim.version().patch,
    --     stats.count,
    --     ms
    -- )
    local slogan = {
        'Vim is a way of life',
        '  🄻 🄸 🄶 🄷 🅃  🅇 🅄 🄴'
    }
    return table.concat(slogan, '\n')
end

return function()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')
    local fortune = require('modules.utils.fortune')
    local btn = dashboard.button
    dashboard.section.header.val = fortune()
    dashboard.section.buttons.val = {
        btn('e', '📝 New file', '<Cmd>ene <CR>'),
        btn('f', '📗 Open file', '<Cmd>Telescope find_files<CR>'),
        btn('b', '📚 Find buffer', '<Cmd>Telescope buffers<CR>'),
        btn('m', '📅 Frecency/MRU', '<Cmd>Telescope oldfiles<CR>'),
        btn('p', '📂 Open project', '<Cmd>Telescope projects<CR>'),
        btn('g', '🔎 Grep text', '<Cmd>Telescope live_grep<CR>'),
        btn('x', '🏃 Quit', '<Cmd>q<CR>'),
    }
    dashboard.section.footer.val = footer()

    alpha.setup(dashboard.opts)

    vim.api.nvim_create_autocmd('User', {
        pattern = 'LazyVimStarted',
        callback = function()
            dashboard.section.header.val = fortune()
            dashboard.section.footer.val = footer()
            pcall(vim.cmd.AlphaRedraw)
        end,
    })

    vim.api.nvim_create_user_command('Startify', function()
        dashboard.section.header.val = fortune()
        dashboard.section.footer.val = footer()
        alpha.start()
    end, {
        bang = true,
        desc = 'require"alpha".start()',
    })
end
