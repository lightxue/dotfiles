local global = require('core.global')

local function load_options()
    local global_local = {

        -- backupdir = global.cache_dir .. "backup/",
        -- directory = global.cache_dir .. "swap/",
        -- pumblend = 10,
        -- spellfile = global.cache_dir .. "spell/en.uft-8.add",
        -- viewdir = global.cache_dir .. "view/",
        -- winblend = 10,

        -- 文件配置
        encoding = 'utf-8',
        fileformats = 'unix,mac,dos',
        backup = false, -- 关闭自动备份文件
        backupskip = '/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim',
        wildignore = '.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**',
        wildignorecase = true, -- 自动补全文件名忽略大小写
        hidden = true,

        -- UI展示
        cursorcolumn = false, -- 高亮当前列
        cursorline = true, -- 高亮当前行
        showcmd = true, -- 显示输入的字符
        ruler = true, -- 显示行号和列号
        number = true, -- 显示行号
        scrolloff = 0, -- 移动时光标最多离底部0行
        showmatch = false, -- 括号匹配暂时跳转
        matchtime = 2, -- 配置括号高亮时间
        showtabline = 1, -- 展示标签栏 0: never 1: only if there are at least two tab pages 2: always

        whichwrap = 'b,s,<,>,[,]', -- 使指定的左右移动光标的键在行首或行尾可以移到前一行或者后一行
        backspace = 'eol,start,indent',
        -- 搜索
        ignorecase = true, -- 搜索时忽略大小写
        smartcase = true, -- 如果关键字里有大小写就严格匹配
        incsearch = true, -- 搜索时动态调到第一个匹配的位置
        wrapscan = true, -- 搜索到文件末时循环到第一个搜索结果
        magic = true, -- 搜索设置相关，\v \V \m \M，详细看help
        hlsearch = true, -- 高亮搜索匹配的结果
        -- tab键配置
        expandtab = true, -- 插入tab时换成合适数量的空格
        shiftwidth = 4, -- 多少个空格替换成一个tab
        smarttab = true, -- 行首的tab用合适的空白符代替
        tabstop = 4, -- 文件里tab代表的空格数
        softtabstop = 4,
        autoindent = true, -- 按语法自动缩进
        -- 不可见字符展示
        wrap = true, -- 自动折行
        linebreak = true, -- 支持折行
        showbreak = '↪ ', -- 展示折行符
        list = true, -- 显示不可见字符"
        listchars = 'tab:>-,nbsp:.,trail:⌴',
        autoread = true,
        autowrite = true,

        clipboard = 'unnamedplus',
        mouse = 'a',

        breakat = [[\ \	;:,!?]],
        breakindentopt = 'shift:2,min:20',
        cmdheight = 2, -- 0, 1, 2
        cmdwinheight = 5,
        complete = '.,w,b,k',
        completeopt = 'menuone,noselect',
        concealcursor = 'niv',
        conceallevel = 0,
        diffopt = 'filler,iwhite,internal,linematch:60,algorithm:patience',
        display = 'lastline',
        equalalways = false,
        errorbells = true,
        foldenable = true,
        foldlevelstart = 99,
        formatoptions = '1jcroql',
        grepformat = '%f:%l:%c:%m',
        grepprg = 'rg --hidden --vimgrep --smart-case --',
        helpheight = 12,
        history = 2000,
        inccommand = 'nosplit',
        infercase = true,
        jumpoptions = 'stack',
        laststatus = 2,
        mousescroll = 'ver:3,hor:6',
        previewheight = 12,
        pumheight = 15,
        redrawtime = 1500,
        relativenumber = false,
        sessionoptions = 'buffers,curdir,help,tabpages,winsize',
        shada = '!,\'500,<50,@100,s10,h',
        shiftround = true,
        shortmess = 'aoOTIcF',
        showmode = false,
        sidescrolloff = 5,
        signcolumn = 'yes',
        splitbelow = false,
        splitkeep = 'cursor',
        splitright = true,
        startofline = false,
        swapfile = false,
        switchbuf = 'usetab,uselast',
        synmaxcol = 2500,
        termguicolors = true,
        timeout = true,
        timeoutlen = 300,
        ttimeout = true,
        ttimeoutlen = 0,
        undodir = global.cache_dir .. 'undo/',
        undofile = true,
        -- Please do NOT set `updatetime` to above 500, otherwise most plugins may not function correctly
        updatetime = 200,
        viewoptions = 'folds,cursor,curdir,slash,unix',
        virtualedit = 'block',
        visualbell = true,
        winminwidth = 10,
        winwidth = 30,
        writebackup = false,
    }

    for name, value in pairs(global_local) do
        vim.o[name] = value
    end

    -- Fix sqlite3 missing-lib issue on Windows
    if global.is_windows then
        -- Download the DLLs form https://www.sqlite.org/download.html
        vim.g.sqlite_clib_path = global.home .. '/Documents/sqlite-dll-win64-x64-3400200/sqlite3.dll'
    end
end

load_options()
