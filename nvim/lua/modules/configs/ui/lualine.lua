return function()
    local icons = {
        diagnostics = require('modules.utils.icons').get('diagnostics', true),
        misc = require('modules.utils.icons').get('misc', true),
        ui = require('modules.utils.icons').get('ui', true),
    }

    local function escape_status()
        local ok, m = pcall(require, 'better_escape')
        return ok and m.waiting and icons.misc.EscapeST or ''
    end

    local _cache = { context = '', bufnr = -1 }
    local function lspsaga_symbols()
        local exclude = {
            ['terminal'] = true,
            ['toggleterm'] = true,
            ['prompt'] = true,
            ['NvimTree'] = true,
            ['help'] = true,
        }
        if vim.api.nvim_win_get_config(0).zindex or exclude[vim.bo.filetype] then
            return '' -- Excluded filetypes
        else
            local currbuf = vim.api.nvim_get_current_buf()
            local ok, lspsaga = pcall(require, 'lspsaga.symbolwinbar')
            if ok and lspsaga:get_winbar() ~= nil then
                _cache.context = lspsaga:get_winbar()
                _cache.bufnr = currbuf
            elseif _cache.bufnr ~= currbuf then
                _cache.context = '' -- Reset [invalid] cache (usually from another buffer)
            end

            return _cache.context
        end
    end

    local function get_cwd()
        local cwd = vim.fn.getcwd()
        local is_windows = require('core.global').is_windows
        if not is_windows then
            local home = require('core.global').home or ''
            if cwd:find(home, 1, true) == 1 then
                cwd = '~' .. cwd:sub(#home + 1)
            end
        end
        return icons.ui.RootFolderOpened .. cwd
    end

    local mini_sections = {
        lualine_a = { 'filetype' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    }
    local outline = {
        sections = mini_sections,
        filetypes = { 'Outline' },
    }
    local diffview = {
        sections = mini_sections,
        filetypes = { 'DiffviewFiles' },
    }

    require('lualine').setup({
        options = {
            icons_enabled = true,
            theme = 'tokyonight',
            disabled_filetypes = {},
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
        },
        sections = {
            lualine_a = { { 'mode' } },
            lualine_b = {
                { 'branch' },
                {
                    'diagnostics',
                    sources = { 'nvim_diagnostic' },
                    symbols = {
                        error = icons.diagnostics.Error,
                        warn = icons.diagnostics.Warning,
                        info = icons.diagnostics.Information,
                        hint = icons.diagnostics.Hint_alt,
                    },
                },
            },
            lualine_c = {
                { 'filename', path = 1 },
                lspsaga_symbols,
            },
            lualine_x = {
                { escape_status },
                { get_cwd },
            },
            lualine_y = {
                { 'filetype', colored = true, icon = { align = 'right' } },
                { 'encoding' },
                {
                    'fileformat',
                    icons_enabled = true,
                    symbols = {
                        unix = 'LF',
                        dos = 'CRLF',
                        mac = 'CR',
                    },
                },
            },
            lualine_z = {
                '%l/%L:%c',
                '%b:0x%B',
            },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {},
        extensions = {
            'quickfix',
            'nvim-tree',
            'nvim-dap-ui',
            'toggleterm',
            'fugitive',
            outline,
            diffview,
        },
    })
end
