local bind = require('keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback

local core_map = {
    -- 文件编辑
    -- ["n|<leader>e"] = map_cr("e " .. global.init_lua):with_noremap():with_silent():with_desc("edit: Edit init.lua"),
    ['n|<leader>fu'] = map_cr('set fileformat=unix'):with_noremap():with_silent():with_desc('edit: Fileformat unix'),
    ['n|<leader>fd'] = map_cr('set fileformat=dos'):with_noremap():with_silent():with_desc('edit: Fileformat dos'),
    ['n|<leader>s'] = map_cu('write'):with_noremap():with_silent():with_desc('edit: Save file'),
    ['n|<leader>xm'] = map_cr('qa'):with_desc('edit: Quit all'),
    ['n|<leader>xx'] = map_cr('q'):with_desc('edit: Quit current window'),
    ['n|<leader>xb'] = map_cr('bd!'):with_desc('edit: Quit buffer'),
    ['n|<leader>xf'] = map_cr('q!'):with_desc('edit: Quit force'),
    ['n|<leader>xk'] = map_cr('q!'):with_desc('edit: Quit force all'),
    -- 移动
    ['n|Y'] = map_cmd('y$'):with_desc('edit: Yank text to EOL'),
    ['n|D'] = map_cmd('d$'):with_desc('edit: Delete text to EOL'),
    ['n|n'] = map_cmd('nzzzv'):with_noremap():with_desc('edit: Next search result'),
    ['n|N'] = map_cmd('Nzzzv'):with_noremap():with_desc('edit: Prev search result'),
    ['n|J'] = map_cmd('mzJ`z'):with_noremap():with_desc('edit: Join next line'),
    ['n|j'] = map_cmd('gj'):with_noremap():with_silent():with_desc('edit: move up'),
    ['n|k'] = map_cmd('gk'):with_noremap():with_silent():with_desc('edit: move down'),
    ['n|<Space>'] = map_cmd('<C-D>'):with_noremap():with_silent():with_desc('edit: Scroll half a screen'),
    ['v|<Space>'] = map_cmd('<C-D>'):with_noremap():with_silent():with_desc('edit: Scroll half a screen'),
    ['v|<leader>t2'] = map_cr('set shiftwidth=2'):with_noremap():with_silent():with_desc('edit: Shiftwidth 2 space'),
    ['v|<leader>t4'] = map_cr('set shiftwidth=4'):with_noremap():with_silent():with_desc('edit: Shiftwidth 4 space'),
    ['v|<leader>t8'] = map_cr('set shiftwidth=8'):with_noremap():with_silent():with_desc('edit: Shiftwidth 8 space'),
    -- 选中模式移动
    ['v|J'] = map_cmd(':m \'>+1<CR>gv=gv'):with_desc('edit: Move this line down'),
    ['v|K'] = map_cmd(':m \'<-2<CR>gv=gv'):with_desc('edit: Move this line up'),
    ['v|<'] = map_cmd('<gv'):with_desc('edit: Decrease indent'),
    ['v|>'] = map_cmd('>gv'):with_desc('edit: Increase indent'),
    --- 窗口操作
    ['n|<C-h>'] = map_cmd('<C-w>h'):with_noremap():with_desc('window: Focus left'),
    ['n|<C-l>'] = map_cmd('<C-w>l'):with_noremap():with_desc('window: Focus right'),
    ['n|<C-j>'] = map_cmd('<C-w>j'):with_noremap():with_desc('window: Focus down'),
    ['n|<C-k>'] = map_cmd('<C-w>k'):with_noremap():with_desc('window: Focus up'),
    ['t|<C-h>'] = map_cmd('<Cmd>wincmd h<CR>'):with_silent():with_noremap():with_desc('window: Focus left'),
    ['t|<C-l>'] = map_cmd('<Cmd>wincmd l<CR>'):with_silent():with_noremap():with_desc('window: Focus right'),
    ['t|<C-j>'] = map_cmd('<Cmd>wincmd j<CR>'):with_silent():with_noremap():with_desc('window: Focus down'),
    ['t|<C-k>'] = map_cmd('<Cmd>wincmd k<CR>'):with_silent():with_noremap():with_desc('window: Focus up'),
    ['n|<A-[>'] = map_cr('vertical resize -5'):with_silent():with_desc('window: Resize -5 vertically'),
    ['n|<A-]>'] = map_cr('vertical resize +5'):with_silent():with_desc('window: Resize +5 vertically'),
    ['n|<A-;>'] = map_cr('resize -2'):with_silent():with_desc('window: Resize -2 horizontally'),
    ['n|<A-\'>'] = map_cr('resize +2'):with_silent():with_desc('window: Resize +2 horizontally'),
    --- 标签页
    ['n|<leader>tn'] = map_cr('tabnew %'):with_noremap():with_silent():with_desc('tab: Create a new tab'),
    ['n|<leader>to'] = map_cr('tabonly'):with_noremap():with_silent():with_desc('tab: Only keep current tab'),
    ['n|<leader>te'] = map_cr('tabedit<CR>:Startify')
        :with_noremap()
        :with_silent()
        :with_desc('tab: Open startify in new tab'),

    ['n|<S-Tab>'] = map_cr('normal za'):with_noremap():with_silent():with_desc('edit: Toggle code fold'),
    ['n|<leader>l'] = map_cmd('<C-L>'):with_noremap():with_silent():with_desc('window: Redraw'),

    ['n|<leader>nw'] = map_callback(function()
            vim.o.wrap = not vim.o.wrap
        end)
        :with_noremap()
        :with_silent()
        :with_desc('edit: Toggle wrap'),

    ['n|<leader>hl'] = map_callback(function()
            vim.o.hlsearch = not vim.o.hlsearch
        end)
        :with_noremap()
        :with_silent()
        :with_desc('edit: Toggle hlsearch'),

    ['n|<leader>cw'] = map_callback(function()
            local save_cursor = vim.fn.getpos('.')
            vim.cmd([[%s/\s\+$//e]])
            vim.cmd([[%s/\r$//e]])
            vim.fn.setpos('.', save_cursor)
        end)
        :with_noremap()
        :with_silent()
        :with_desc('edit: Clean trailing whitespace'),

    ['n|<leader>ms'] = map_callback(function()
            if vim.o.mouse == 'a' then
                vim.o.mouse = ''
                vim.o.number = false
                vim.api.nvim_command('Gitsigns toggle_signs false')
            else
                vim.o.mouse = 'a'
                vim.o.number = true
                vim.api.nvim_command('Gitsigns toggle_signs true')
            end
        end)
        :with_noremap()
        :with_silent()
        :with_desc('edit: Toggle mouse mode'),
    -- Suckless
    -- ["n|<Esc>"] = map_cr("noh"):with_noremap():with_silent():with_desc("edit: Clear search highlight"),
    -- ["n|<C-q>"] = map_cr("wq"):with_desc("edit: Save file and quit"),
    -- ["n|<leader>o"] = map_cr("setlocal spell! spelllang=en_us"):with_desc("edit: Toggle spell check"),
    -- Insert mode
    -- ["i|<C-u>"] = map_cmd("<C-G>u<C-U>"):with_noremap():with_desc("edit: Delete previous block"),
    -- ["i|<C-b>"] = map_cmd("<Left>"):with_noremap():with_desc("edit: Move cursor to left"),
    -- ["i|<C-a>"] = map_cmd("<ESC>^i"):with_noremap():with_desc("edit: Move cursor to line start"),
    -- ["i|<C-s>"] = map_cmd("<Esc>:w<CR>"):with_desc("edit: Save file"),
    -- ["i|<C-q>"] = map_cmd("<Esc>:wq<CR>"):with_desc("edit: Save file and quit"),
    -- 在命令模式下也能用Bash快捷键
    ['c|<C-b>'] = map_cmd('<Left>'):with_noremap():with_desc('edit: Left'),
    ['c|<C-f>'] = map_cmd('<Right>'):with_noremap():with_desc('edit: Right'),
    ['c|<C-a>'] = map_cmd('<Home>'):with_noremap():with_desc('edit: Home'),
    ['c|<C-e>'] = map_cmd('<End>'):with_noremap():with_desc('edit: End'),
    ['c|<C-d>'] = map_cmd('<Del>'):with_noremap():with_desc('edit: Delete'),
    ['c|<C-h>'] = map_cmd('<BS>'):with_noremap():with_desc('edit: Backspace'),
    ['c|<C-p>'] = map_cmd('<Up>'):with_noremap():with_desc('edit: Up'),
    ['c|<C-n>'] = map_cmd('<Down>'):with_noremap():with_desc('edit: Down'),
    ['c|<C-t>'] = map_cmd([[<C-R>=expand("%:p:h") . "/" <CR>]])
        :with_noremap()
        :with_desc('edit: Complete path of current file'),
}

bind.nvim_load_mapping(core_map)
