return function()
    require('nvim-treesitter-textobjects').setup({
        select = {
            lookahead = true,
            selection_modes = {
                ['@parameter.outer'] = 'v',
                ['@function.outer'] = 'V',
                ['@class.outer'] = '<c-v>',
            },
        },
        move = {
            set_jumps = true,
        },
    })
end
