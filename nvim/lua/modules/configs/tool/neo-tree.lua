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
            filtered_items = {
                visible = false, -- when true, they will just be displayed differently than normal items
                hide_dotfiles = true,
                hide_gitignored = false,
                hide_hidden = true, -- only works on Windows for hidden files/directories
                hide_by_name = {
                    --"node_modules"
                },
                hide_by_pattern = { -- uses glob style patterns
                    --"*.meta",
                    --"*/src/*/tsconfig.json",
                },
                always_show = { -- remains visible even if other settings would normally hide it
                    --".gitignored",
                },
                never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                    '.DS_Store',
                    'thumbs.db',
                },
                never_show_by_pattern = { -- uses glob style patterns
                    --".null-ls_*",
                },
            },
            follow_current_file = {
                enabled = false, -- This will find and focus the file in the active buffer every time
                --               -- the current file is changed while the tree is open.
                leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
            },
            group_empty_dirs = false, -- when true, empty folders will be grouped together
            hijack_netrw_behavior = 'open_current', -- netrw disabled, opening a directory opens neo-tree
            --                                         in whatever position is specified in window.position
            --                      "open_current",  -- netrw disabled, opening a directory opens within the
            --                                         window like netrw would, regardless of window.position
            --                       "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
            use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
            --                                 instead of relying on nvim autocmd events.
        },
        default_component_configs = {
            git_status = {
                symbols = require('modules.utils.icons').get('neo_tree_git'),
            },
        },
    })
end
