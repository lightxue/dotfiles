local bind = require('keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback
require('keymap.helpers')

local plug_map = {
    -- Plugin: vim-fugitive
    ['n|<leader>gs'] = map_cr('Git'):with_noremap():with_silent():with_desc('git: Status'),
    ['n|<leader>gc'] = map_cr('Git commit'):with_noremap():with_silent():with_desc('git: Commit'),
    ['n|<leader>gpl'] = map_cr('Git pull'):with_noremap():with_silent():with_desc('git: Pull'),
    ['n|<leader>gps'] = map_cr('Git push'):with_noremap():with_silent():with_desc('git: Push'),
    ['n|<leader>gl'] = map_cr('Gllog'):with_noremap():with_silent():with_desc('git: Log'),
    ['n|<leader>gv'] = map_cr('GV'):with_noremap():with_silent():with_desc('git: View'),
    ['n|<leader>gb'] = map_cr('GitBlameToggle'):with_noremap():with_silent():with_desc('git: Blame'),
    -- Plugin: diffview TODO 改成toggle
    ['n|<leader>gd'] = map_cr('DiffviewOpen'):with_silent():with_noremap():with_desc('git: Show diff'),
    ['n|<leader>gD'] = map_cr('DiffviewClose'):with_silent():with_noremap():with_desc('git: Close diff'),
    -- Plugin: nvim-tree
    -- ["n|<C-n>"] = map_cr("NvimTreeToggle"):with_noremap():with_silent():with_desc("filetree: Toggle"),
    -- ["n|<leader>nf"] = map_cr("NvimTreeFindFile"):with_noremap():with_silent():with_desc("filetree: Find file"),
    -- ["n|<leader>nr"] = map_cr("NvimTreeRefresh"):with_noremap():with_silent():with_desc("filetree: Refresh"),
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
    ['i|<leader>tt'] = map_cmd('<Esc><Cmd>ToggleTerm<CR>')
        :with_noremap()
        :with_silent()
        :with_desc('terminal: Toggle horizontal'),
    ['n|<leader>ts'] = map_cr([[execute v:count . "ToggleTerm direction=horizontal"]])
        :with_noremap()
        :with_silent()
        :with_desc('terminal: Toggle horizontal'),
    ['i|<leader>ts'] = map_cmd('<Esc><Cmd>ToggleTerm direction=horizontal<CR>')
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
    ['i|<leader>tv'] = map_cmd('<Esc><Cmd>ToggleTerm direction=vertical<CR>')
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
    ['i|<leader>tf'] = map_cmd('<Esc><Cmd>ToggleTerm direction=float<CR>')
        :with_noremap()
        :with_silent()
        :with_desc('terminal: Toggle float'),
    ['t|<leader>tf'] = map_cmd('<Cmd>ToggleTerm<CR>'):with_noremap():with_silent():with_desc('terminal: Toggle float'),
    ['n|<leader>tg'] = map_callback(function()
            _toggle_lazygit()
        end)
        :with_noremap()
        :with_silent()
        :with_desc('git: Toggle lazygit'),

    -- Plugin: trouble
    ['n|<leader>ee'] = map_cr('TroubleToggle'):with_noremap():with_silent():with_desc('lsp: Toggle trouble list'),
    ['n|<leader>er'] = map_cr('TroubleToggle lsp_references')
        :with_noremap()
        :with_silent()
        :with_desc('lsp: Show lsp references'),
    ['n|<leader>ed'] = map_cr('TroubleToggle document_diagnostics')
        :with_noremap()
        :with_silent()
        :with_desc('lsp: Show document diagnostics'),
    ['n|<leader>ew'] = map_cr('TroubleToggle workspace_diagnostics')
        :with_noremap()
        :with_silent()
        :with_desc('lsp: Show workspace diagnostics'),
    ['n|<leader>eq'] = map_cr('TroubleToggle quickfix')
        :with_noremap()
        :with_silent()
        :with_desc('lsp: Show quickfix list'),
    ['n|<leader>el'] = map_cr('TroubleToggle loclist'):with_noremap():with_silent():with_desc('lsp: Show loclist'),

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
    ['n|<leader>fe'] = map_cu('Telescope oldfiles'):with_noremap():with_silent():with_desc('find: File by history'),
    ['n|<leader>ff'] = map_cu('Telescope find_files'):with_noremap():with_silent():with_desc('find: File in project'),
    -- ["n|<leader>fc"] = map_cu("Telescope colorscheme")
    -- 	:with_noremap()
    -- 	:with_silent()
    -- 	:with_desc("ui: Change colorscheme for current session"),
    ['n|<leader>fn'] = map_cu(':enew'):with_noremap():with_silent():with_desc('buffer: New'),
    -- ["n|<leader>fg"] = map_cu("Telescope git_files")
    -- 	:with_noremap()
    -- 	:with_silent()
    -- 	:with_desc("find: file in git project"),
    ['n|<leader>fj'] = map_cu('Telescope jump by zoxide')
        :with_noremap()
        :with_silent()
        :with_desc('edit: Change current direrctory by zoxide'),
    ['n|<leader>fb'] = map_cu('Telescope buffers'):with_noremap():with_silent():with_desc('find: Buffer opened'),
    -- ["n|<leader>fs"] = map_cu("Telescope grep_string"):with_noremap():with_silent():with_desc("find: Current word"),

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
