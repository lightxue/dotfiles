return function()
    require('interestingwords').setup({
        colors = {
            '#D35242',
            '#26C09F',
            '#3F9FCC',
            '#EAE17F',
            '#A261B1',
            '#F59007',
            '#C0F4FC',
            '#D695AA',
            '#E2EAC1',
            '#F5D27A',
            '#E44385',
        },
        search_count = true,
        navigation = true,
        search_key = '<leader><leader>m',
        cancel_search_key = '<leader><leader>mc',
        color_key = '<leader>mm',
        cancel_color_key = '<leader>mc',
    })
end
