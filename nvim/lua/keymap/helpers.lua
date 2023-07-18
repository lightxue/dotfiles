_G._command_panel = function()
    require('telescope.builtin').keymaps({
        lhs_filter = function(lhs)
            return not string.find(lhs, 'Þ')
        end,
        layout_config = {
            width = 0.6,
            height = 0.6,
            prompt_position = 'top',
        },
    })
end
