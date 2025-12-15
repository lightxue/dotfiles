return vim.schedule_wrap(function()
    local use_ssh = require('core.settings').use_ssh

    vim.api.nvim_set_option_value('foldmethod', 'expr', {})
    vim.api.nvim_set_option_value('foldexpr', 'nvim_treesitter#foldexpr()', {})

    require('nvim-treesitter').setup({})

    require('nvim-treesitter').install({
        'bash',
        'c',
        'cpp',
        'css',
        'go',
        'gomod',
        'html',
        'javascript',
        'json',
        'latex',
        'lua',
        'make',
        'markdown',
        'markdown_inline',
        'python',
        'typescript',
        'vimdoc',
        'vue',
        'yaml',
    })

    require('nvim-treesitter.install').prefer_git = true
    if use_ssh then
        local parsers = require('nvim-treesitter.parsers').get_parser_configs()
        for _, p in pairs(parsers) do
            p.install_info.url = p.install_info.url:gsub('https://github.com/', 'git@github.com:')
        end
    end
end)
