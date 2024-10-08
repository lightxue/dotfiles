local bind = require('keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback
require('keymap.helpers')

local function get_shebang_cmd()
    local shebang_head = '#!'
    local lines = vim.api.nvim_buf_get_lines(0, 0, 1, true)
    local first_line = #lines > 0 and lines[1] or ''
    if first_line:find(shebang_head, 1, true) == 1 then
        return first_line:sub(#shebang_head + 1)
    end
    return nil
end

local ft_cmd = {
    python = 'python3',
    lua = 'lua',
    javascript = 'node',
    go = 'go run',
    sh = 'bash',
    c = 'gcc',
    cpp = 'g++',
}
local function get_filetype_cmd()
    return ft_cmd[vim.bo.filetype]
end

local function run_current_file()
    local fn = vim.fn.expand('%:p')
    local cmd = get_shebang_cmd() or get_filetype_cmd()
    if cmd == nil then
        vim.notify('Not proper command to run current file', vim.log.levels.ERROR)
        return
    elseif fn == nil or fn == '' then
        vim.notify('Invalid file path to run', vim.log.levels.ERROR)
        return
    end
    require('toggleterm').exec(cmd .. ' ' .. fn)
end

local plug_map = {
    -- Plugin: vim-fugitive
    ['n|<leader>gs'] = map_callback(function()
            local windows = vim.api.nvim_list_wins()
            for _, win in ipairs(windows) do
                local buf = vim.api.nvim_win_get_buf(win)
                local buf_name = vim.api.nvim_buf_get_name(buf)
                if string.match(buf_name, 'fugitive://.*/.git//$') then
                    vim.api.nvim_win_close(win, true)
                    return
                end
            end
            vim.cmd('Git')
            vim.cmd('resize 13')
        end)
        :with_noremap()
        :with_silent()
        :with_desc('git: Toggle status'),
    ['n|<leader>gc'] = map_cr('Git commit'):with_noremap():with_silent():with_desc('git: Commit'),
    ['n|<leader>gl'] = map_cr('Git pull'):with_noremap():with_silent():with_desc('git: Pull'),
    ['n|<leader>gp'] = map_cr('Git push'):with_noremap():with_silent():with_desc('git: Push'),
    ['n|<leader>gv'] = map_cr('GV'):with_noremap():with_silent():with_desc('git: View'),
    ['n|<leader>gd'] = map_callback(function()
            local windows = vim.api.nvim_list_wins()
            for _, win in ipairs(windows) do
                local buf = vim.api.nvim_win_get_buf(win)
                local buf_name = vim.api.nvim_buf_get_name(buf)
                if string.match(buf_name, 'fugitive://.*/.git//.+') then
                    vim.api.nvim_win_close(win, true)
                    return
                end
            end
            vim.cmd('Gvdiffsplit')
        end)
        :with_silent()
        :with_noremap()
        :with_desc('git: Toggle diff this'),
    -- Plugin: diffview TODO 改成toggle
    ['n|<leader>gD'] = map_cr('DiffviewOpen'):with_silent():with_noremap():with_desc('git: Show diff view'),
    -- Plugin: neo-tree
    ['n|<leader>nt'] = map_cr('Neotree toggle filesystem left')
        :with_noremap()
        :with_silent()
        :with_desc('filetree: toggle view'),

    -- Plugin: sniprun
    ['v|<leader>r'] = map_cr('SnipRun'):with_noremap():with_silent():with_desc('tool: Run code by range'),
    ['n|<leader>r'] = map_cu([[%SnipRun]]):with_noremap():with_silent():with_desc('tool: Run code by file'),

    -- vim.keymap.set('n', '<leader>th', '<cmd>ToggleTerm direction=horizontal<CR>', kmopts)
    -- vim.keymap.set('n', '<leader>ts', '<cmd>ToggleTermSendCurrentLine<CR>', kmopts)
    -- vim.keymap.set('v', '<leader>ts', '<cmd>ToggleTermSendVisualSelection<CR>', kmopts)
    -- vim.keymap.set('n', '<leader>tr', run_current_file, kmopts)
    -- vim.keymap.set('n', '<leader>tl', "<cmd>TermExec cmd='r'<CR>", kmopts) -- run last command in zsh
    -- Plugin: toggleterm
    ['t|<Esc><Esc>'] = map_cmd([[<C-\><C-n>]]):with_noremap():with_silent(), -- switch to normal mode in terminal.
    ['t|jk'] = map_cmd([[<C-\><C-n>]]):with_noremap():with_silent(), -- switch to normal mode in terminal.
    ['n|<leader>tt'] = map_cr([[execute v:count . "ToggleTerm"]])
        :with_noremap()
        :with_silent()
        :with_desc('terminal: Toggle horizontal'),
    ['n|<leader>ts'] = map_cr([[execute v:count . "ToggleTerm direction=horizontal"]])
        :with_noremap()
        :with_silent()
        :with_desc('terminal: Toggle horizontal'),
    ['t|<leader>ts'] = map_cmd('<Cmd>ToggleTerm<CR>')
        :with_noremap()
        :with_silent()
        :with_desc('terminal: Toggle horizontal'),
    ['n|<leader>tv'] = map_cr([[execute v:count . "ToggleTerm direction=vertical"]])
        :with_noremap()
        :with_silent()
        :with_desc('terminal: Toggle vertical'),
    ['t|<leader>tv'] = map_cmd('<Cmd>ToggleTerm<CR>')
        :with_noremap()
        :with_silent()
        :with_desc('terminal: Toggle vertical'),
    ['n|<leader>tf'] = map_cr([[execute v:count . "ToggleTerm direction=float"]])
        :with_noremap()
        :with_silent()
        :with_desc('terminal: Toggle float'),
    ['t|<leader>tf'] = map_cmd('<Cmd>ToggleTerm<CR>'):with_noremap():with_silent():with_desc('terminal: Toggle float'),
    ['n|<leader>tr'] = map_callback(run_current_file)
        :with_noremap()
        :with_silent()
        :with_desc('terminal: Run current file'),

    -- Plugin: trouble
    ['n|<leader>ee'] = map_cr('Trouble diagnostics toggle')
        :with_noremap()
        :with_silent()
        :with_desc('lsp: Toggle trouble list'),
    ["n|<leader>ep"] = map_cr("Trouble project_diagnostics toggle")
        :with_noremap()
        :with_silent()
        :with_desc("lsp: Show project diagnostics"),
    ["n|<leader>ed"] = map_cr("Trouble diagnostics toggle filter.buf=0")
        :with_noremap()
        :with_silent()
        :with_desc("lsp: Show document diagnostics"),

    -- Plugin: telescope
    ['n|<C-p>'] = map_callback(function()
            _command_panel()
        end)
        :with_noremap()
        :with_silent()
        :with_desc('tool: Toggle command panel'),
    ['n|<leader>ut'] = map_callback(function()
            require('telescope').extensions.undo.undo()
        end)
        :with_noremap()
        :with_silent()
        :with_desc('edit: Show undo history'),
    ['n|<leader>fp'] = map_callback(function()
            require('telescope').extensions.projects.projects({})
        end)
        :with_noremap()
        :with_silent()
        :with_desc('find: Project'),
    ['n|<leader>fm'] = map_callback(function()
            require('telescope').extensions.frecency.frecency()
        end)
        :with_noremap()
        :with_silent()
        :with_desc('find: File by frecency'),
    ['n|<leader>fg'] = map_callback(function()
            require('telescope').extensions.live_grep_args.live_grep_args()
        end)
        :with_noremap()
        :with_silent()
        :with_desc('find: Word in project'),
    -- ['n|<leader>fe'] = map_cu('Telescope oldfiles'):with_noremap():with_silent():with_desc('find: File by history'),
    ['n|<leader>ff'] = map_cu('Telescope find_files'):with_noremap():with_silent():with_desc('find: File in project'),
    ['n|<leader>fc'] = map_cu('Telescope neoclip'):with_noremap():with_silent():with_desc('find: Clipboard'),
    ['n|<leader>fn'] = map_cu('Telescope notify'):with_noremap():with_silent():with_desc('find: Notify history'),
    ['n|<leader>fj'] = map_cu('Telescope jump by zoxide')
        :with_noremap()
        :with_silent()
        :with_desc('edit: Change current direrctory by zoxide'),
    ['n|<leader>fb'] = map_cu('Telescope buffers'):with_noremap():with_silent():with_desc('find: Buffer opened'),
    ['n|<leader>fh'] = map_cu('Telescope help_tags'):with_noremap():with_silent():with_desc('find: Help tags'),
    ['n|<leader>ft'] = map_cu('Telescope treesitter'):with_noremap():with_silent():with_desc('find: Treesitter'),

    -- Plugin: dap
    ['n|<F6>'] = map_callback(function()
            require('dap').terminate()
            require('dapui').close()
        end)
        :with_noremap()
        :with_silent()
        :with_desc('debug: Stop'),
    ['n|<F7>'] = map_callback(function()
            require('dap').continue()
        end)
        :with_noremap()
        :with_silent()
        :with_desc('debug: Run/Continue'),
    ['n|<F8>'] = map_callback(function()
            require('dap').toggle_breakpoint()
        end)
        :with_noremap()
        :with_silent()
        :with_desc('debug: Toggle breakpoint'),
    ['n|<F9>'] = map_callback(function()
            require('dap').run_to_cursor()
        end)
        :with_noremap()
        :with_silent()
        :with_desc('debug: Run to cursor'),
    ['n|<F10>'] = map_callback(function()
            require('dap').step_over()
        end)
        :with_noremap()
        :with_silent()
        :with_desc('debug: Step over'),
    ['n|<F11>'] = map_callback(function()
            require('dap').step_into()
        end)
        :with_noremap()
        :with_silent()
        :with_desc('debug: Step into'),
    ['n|<F12>'] = map_callback(function()
            require('dap').step_out()
        end)
        :with_noremap()
        :with_silent()
        :with_desc('debug: Step out'),
    ['n|<leader>bb'] = map_callback(function()
            require('dap').toggle_breakpoint()
        end)
        :with_noremap()
        :with_silent()
        :with_desc('debug: Toggle breakpoint'),
    ['n|<leader>dB'] = map_callback(function()
            require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
        end)
        :with_noremap()
        :with_silent()
        :with_desc('debug: Set breakpoint with condition'),
    ['n|<leader>dc'] = map_callback(function()
            require('dap').run_to_cursor()
        end)
        :with_noremap()
        :with_silent()
        :with_desc('debug: Run to cursor'),
    ['n|<leader>dl'] = map_callback(function()
            require('dap').run_last()
        end)
        :with_noremap()
        :with_silent()
        :with_desc('debug: Run last'),
    ['n|<leader>do'] = map_callback(function()
            require('dap').repl.open()
        end)
        :with_noremap()
        :with_silent()
        :with_desc('debug: Open REPL'),
    -- Plugin: SwissCalc
    ['n|<leader>nn'] = map_cr('Scalc'):with_noremap():with_silent():with_desc('cal: SwissCalc'),
}

bind.nvim_load_mapping(plug_map)
