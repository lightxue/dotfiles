return function()
    vim.g.neo_tree_remove_legacy_commands = 1
    require('neo-tree').setup({
        window = {
            mappings = {
                ['u'] = 'navigate_up',
                ['C'] = 'set_root',
                ['h'] = 'toggle_hidden',
                ['Z'] = 'close_all_nodes',
                ['<2-LeftMouse>'] = 'noop',
                ['.'] = 'noop',
                ['z'] = 'noop',
                ['w'] = 'noop',
                ['/'] = 'noop',
                ['D'] = 'noop',
                ['#'] = 'noop',
                ['f'] = 'noop',
                ['<Space>'] = 'noop',
            },
        },
        filesystem = {
            follow_current_file = false, -- This will find and focus the file in the active buffer every
            -- time the current file is changed while the tree is open.
            group_empty_dirs = false, -- when true, empty folders will be grouped together
            hijack_netrw_behavior = 'open_current', -- netrw disabled, opening a directory opens neo-tree
                -- in whatever position is specified in window.position
                -- "open_current",  -- netrw disabled, opening a directory opens within the
                -- window like netrw would, regardless of window.position
                -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
            use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
            -- instead of relying on nvim autocmd events.
        },
    })
end
