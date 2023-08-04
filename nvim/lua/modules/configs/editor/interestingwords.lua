return function()
    require('interestingwords').setup({
        colors = {
            '#E44385',
            '#D05663',
            '#D695AA',
            '#A261B1',
            '#D35242',
            '#F59007',
            '#FAD4BA',
            '#F6F4E8',
            '#C3E88D',
            '#26C09F',
            '#A1EFD3',
            '#C0F4FC',
            '#8CA9D3',
            '#3F9FCC',
        },
        search_count = true,
        navigation = true,
        search_key = '<leader><leader>m',
        cancel_search_key = '<leader><leader>mc',
        color_key = '<leader>mm',
        cancel_color_key = '<leader>mc',
    })
end
