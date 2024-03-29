local bind = require('keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback
local et = bind.escape_termcode

local plug_map = {
    -- Plugin: accelerate-jk
    ['n|j'] = map_callback(function()
        return et('<Plug>(accelerated_jk_gj)')
    end):with_expr(),
    ['n|k'] = map_callback(function()
        return et('<Plug>(accelerated_jk_gk)')
    end):with_expr(),

    -- Plugin: clever-f
    ['n|;'] = map_callback(function()
        return et('<Plug>(clever-f-repeat-forward)')
    end):with_expr(),
    ['n|,'] = map_callback(function()
        return et('<Plug>(clever-f-repeat-back)')
    end):with_expr(),

    -- Plugin: comment.nvim
    ['n|gcc'] = map_callback(function()
            return vim.v.count == 0 and et('<Plug>(comment_toggle_linewise_current)')
                or et('<Plug>(comment_toggle_linewise_count)')
        end)
        :with_silent()
        :with_noremap()
        :with_expr()
        :with_desc('edit: Toggle comment for line'),
    ['n|gbc'] = map_callback(function()
            return vim.v.count == 0 and et('<Plug>(comment_toggle_blockwise_current)')
                or et('<Plug>(comment_toggle_blockwise_count)')
        end)
        :with_silent()
        :with_noremap()
        :with_expr()
        :with_desc('edit: Toggle comment for block'),
    ['n|gc'] = map_cmd('<Plug>(comment_toggle_linewise)')
        :with_silent()
        :with_noremap()
        :with_desc('edit: Toggle comment for line with operator'),
    ['n|gb'] = map_cmd('<Plug>(comment_toggle_blockwise)')
        :with_silent()
        :with_noremap()
        :with_desc('edit: Toggle comment for block with operator'),
    ['x|gc'] = map_cmd('<Plug>(comment_toggle_linewise_visual)')
        :with_silent()
        :with_noremap()
        :with_desc('edit: Toggle comment for line with selection'),
    ['x|gb'] = map_cmd('<Plug>(comment_toggle_blockwise_visual)')
        :with_silent()
        :with_noremap()
        :with_desc('edit: Toggle comment for block with selection'),

    -- Plugin: vim-easy-align
    ['v|<Enter>'] = map_cr('EasyAlign'):with_desc('edit: Align with delimiter'),

    ['nv|<leader>w'] = map_cmd('<Cmd>HopWord<CR>'):with_noremap():with_desc('jump: Goto word'),

    -- Plugin: treehopper
    ['o|m'] = map_cu('lua require(\'tsht\').nodes()'):with_silent():with_desc('jump: Operate across syntax tree'),

    -- Plugin suda.vim
    ['n|<leader>fs'] = map_cu('SudaWrite'):with_silent():with_noremap():with_desc('edit: Save file using sudo'),
}

bind.nvim_load_mapping(plug_map)
