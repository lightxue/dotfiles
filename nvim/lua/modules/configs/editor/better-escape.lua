return function()
    require("better_escape").setup {
        timeout = vim.o.timeoutlen,
        default_mappings = true,
        mappings = {
            i = {
                j = {
                    -- These can all also be functions
                    k = "<Esc>",
                    K = "<Esc>",
                },
                J = {
                    k = "<Esc>",
                    K = "<Esc>",
                },
            },
            c = {
                j = {
                    k = "<Esc>",
                    K = "<Esc>",
                },
                J = {
                    k = "<Esc>",
                    K = "<Esc>",
                },
            },
            t = {
                j = {
                    k = "<Esc>",
                    K = "<Esc>",
                },
                J = {
                    k = "<Esc>",
                    K = "<Esc>",
                },
            },
            v = {
                j = {
                    k = "<Esc>",
                    K = "<Esc>",
                },
                J = {
                    k = "<Esc>",
                    K = "<Esc>",
                },
            },
            s = {
                j = {
                    k = "<Esc>",
                    K = "<Esc>",
                },
                J = {
                    k = "<Esc>",
                    K = "<Esc>",
                },
            },
        },
    }
end
