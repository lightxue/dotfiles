return function()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')
    local fortune = require('modules.utils.fortune')
    local btn = dashboard.button
    dashboard.section.header.val = fortune()
    dashboard.section.buttons.val = {
        btn('e', '  New file', '<Cmd>ene <CR>'),
        -- btn('s', '  Scratch', '<Cmd>Scratch<CR>'),
        btn('f', '  Find file', '<Cmd>Telescope find_files<CR>'),
        btn('m', '  Frecency/MRU', '<Cmd>Telescope oldfiles<CR>'),
        btn('p', '  Find project', '<Cmd>Telescope projects<CR>'),
        btn('b', '  Find buffer', '<Cmd>Telescope buffers<CR>'),
        btn('w', '  Find word', '<Cmd>Telescope live_grep<CR>'),
        btn('x', '  Quit', '<Cmd>q<CR>'),
    }
    dashboard.section.footer.val = [[
Vim is a way of life
  🄻 🄸 🄶 🄷 🅃  🅇 🅄 🄴
    ]]

    alpha.setup(dashboard.opts)

    vim.api.nvim_create_autocmd('User', {
        pattern = 'LazyVimStarted',
        callback = function()
            dashboard.section.header.val = fortune()
            pcall(vim.cmd.AlphaRedraw)
        end,
    })

    vim.api.nvim_create_user_command('Startify', function()
        dashboard.section.header.val = fortune()
        alpha.start()
    end, {
        bang = true,
        desc = 'require"alpha".start()',
    })
end
