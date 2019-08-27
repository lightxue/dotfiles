" leader设置
let mapleader = ","
let g:mapleader = ","

inoremap jk <Esc>
"xnoremap jk <Esc>
cnoremap jk <C-c>
"inoremap <C-]> <Nop>
"inoremap <Esc> <Nop>

" 编辑配置文件
map <Leader>e :e $MYVIMRC<CR>
"map <Leader>e :exec "e ".expand(g:_vimrc)<CR>
" 另一种在命令模式下展开变量的方法
" map <Leader>e :e <C-R>=expand(g:_vimrc)<CR><CR>
" 更新配置
map <Leader>uu :source $MYVIMRC<CR>
autocmd! bufwritepost .vimrc source $MYVIMRC "修改配置文件后更新

" 上下移动行
nmap <M-J> mz:m+<CR>`z
nmap <M-K> mz:m-2<CR>`z
vmap <M-J> :m'>+<CR>`<my`>mzgv`yo`z
vmap <M-K> :m'<-2<CR>`>my`<mzgv`yo`z

" 刷新屏幕
nnoremap <Leader>l <C-L>

" 修改文件换行方式
nmap <Leader>fd :set ff=dos<CR>
nmap <Leader>fu :set ff=unix<CR>
" nmap <Leader>fm :set ff=mac<CR>

" 行回绕时移动比较符合直觉
nmap j gj
nmap k gk

" 有多个窗口时方便移动
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l
map <C-Up> <C-W>-
map <C-Down> <C-W>+
map <C-Left> <C-W><
map <C-Right> <C-W>>

" 保存文件
" NOTE: 在shell下<c-s>是锁屏(<c-q>解锁)"
map <C-S> <Esc>:w<CR>
imap <C-S> <Esc>:w<CR>a
vmap <C-S> <Esc>:w<CR>
nmap <Leader>s :w!<CR>

" 标签页
map <Leader>tn :tabnew %<CR>
map <Leader>tc :tabclose<CR>
map <Leader>te :tabedit<CR>:Startify<CR>
map <Leader>tm :tabmove<Space>
nmap <C-Tab> gt
nmap <C-S-Tab> gT

" 空格翻页比较符合习惯
map <Space> <C-D>

" 在可视模式下按*或#可以对选中的部分进行搜索
vnoremap <Silent> * :call VisualSearch('f')<CR>
vnoremap <Silent> # :call VisualSearch('b')<CR>

" 设置tab宽度
map <Leader>t2 :set shiftwidth=2<CR>
map <Leader>t4 :set shiftwidth=4<CR>
map <Leader>t8 :set shiftwidth=8<CR>

"" 快速签名
"iab xdatetime <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>
"iab xtime <C-R>=strftime("%H:%M:%S")<CR>
"iab xdate <C-R>=strftime("%Y-%m-%d")<CR>
"iab xname lightxue

" vimgrep递归搜索
map <Leader>ga :Ack 
" vimgrep 搜索当前文件
map <Leader>gg :vimgrep // <C-R>%<home><Right><Right><Right><Right><Right><Right><Right><Right><Right>

" 一步加载语法模板和作者、时间信息 [非插入模式]
map <C-E> <Esc>:LoadTemplate<CR><Esc>:AuthorInfoDetect<CR><Esc>
vmap <C-E> <Esc>:LoadTemplate<CR><Esc>:AuthorInfoDetect<CR><Esc>

" 打开NERDTree [非插入模式]
map <Leader>nt :NERDTreeToggle<CR>
" 打开Taglist [非插入模式]
map <Leader>tl :Tlist<CR>
" 打开Tagbar [非插入模式]
map <Leader>tb :TagbarToggle<CR>
" 选择tag
map <Leader>ts :tselect<CR>
" 打开undotree [非插入模式]
map <Leader>ut :UndotreeToggle<CR>

" 可视模式下加各种括号和引号
vnoremap ( <Esc>`>a)<Esc>`<i(<Esc>
vnoremap [ <Esc>`>a]<Esc>`<i[<Esc>
vnoremap { <Esc>`>a}<Esc>`<i{<Esc>
"vnoremap < <Esc>`>a><Esc>`<i<<Esc> "影响到缩进了
vnoremap ' <Esc>`>a'<Esc>`<i'<Esc>
vnoremap ` <Esc>`>a`<Esc>`<i`<Esc>
"vnoremap " <Esc>`>a"<Esc>`<i"<Esc> "影响到复制了

" 缩进快捷键
"nmap <Tab> V>
"nmap <S-Tab> V<
"vmap <Tab> >gv
"vmap <S-Tab> <gv
vmap > >gv
vmap < <gv

" 代码跳转时有多种结果自动提示
nmap <C-]> g<C-]>

" 在命令模式下也能用Bash快捷键
cmap <C-A> <Home>
cmap <C-E> <End>
cnoremap <C-B> <Left>
cnoremap <C-F> <Right>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>
cnoremap <C-D> <Del>

" windows全屏
if has('win32')
  map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
endif

nmap <F5> :SCCompile<CR>
nmap <F7> :SCCompileRun<CR>

" 方便远程连接时所有模式关闭鼠标，方便使用鼠标拷贝
map <Leader>ms :call ToggleMouse()<CR>

" 某些时候自动换目录不方便
map <Leader>ad :call ToggleAutochdir()<CR>

" 当前行和列高亮开关
map <Leader>hc :call ToggleCursorLine()<CR>

" 粘贴模式开关
map <Leader>ps :call TogglePaste()<CR>

" 搜索高亮开关
"nmap <Leader>hl :call ToggleHlsearch()<CR>
nmap <Leader>hl :nohlsearch<CR>

" 行尾回绕开关
nmap <Leader>nw :call ToggleWrap()<CR>

" buffer相关
map <Leader>bd :bd!<CR>

" 关闭
nmap <Leader>qa :qa<CR>
nmap <Leader>qq :q<CR>
nmap <Leader>qf :q!<CR>
nmap <Leader>qaf :qa!<CR>

nmap <Leader>pd :CtrlPDir 
nmap <Leader>pc :CtrlPClearCache<CR>

nmap <Leader>hh :A<CR>
nmap <Leader>av :AV<CR>

"nunmap <Leader>h
nnoremap <Leader>mk :make -j$(grep --count processor /proc/cpuinfo)<CR>

nnoremap <Leader>mr :MRU<CR>

"" FuzzyFinder快捷键
""nnoremap <silent> <C-]> :FufBufferTagWithCursorWord!<CR>
""vnoremap <silent> <C-]> :FufBufferTagAllWithSelectedText!<CR>

"nmap <Leader>fb :FufBuffer<CR>
"nmap <Leader>ff :FufFile<CR>
"nmap <Leader>fd :FufDir<CR>
"nmap <Leader>ft :FufTag<CR>
"nmap <Leader>fj :FufJumpList<CR>
"nmap <Leader>fl :FufLine<CR>
"nmap <Leader>fh :FufHelp<CR>

nmap <Leader>cv :ConqueTermVSplit zsh --login<CR>
nmap <Leader>ct :ConqueTermTab zsh --login<CR>

nmap <Leader>tg :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
nmap <Leader>fs :%!sudo cat > %<CR>

nmap <Leader>K :call ManualSearch()<CR>

nmap <Leader>cll :Scalc<CR>
nmap <Leader>cls :ScalcSplit<CR>
nmap <Leader>clv :ScalcVSplit<CR>
nmap <Leader>clt :ScalcTab<CR>

nmap <Leader>cw :call CleanWhiteSpace()<CR>

vmap <Enter> <Plug>(EasyAlign)

nmap <Leader>cg :Scratch<CR>

nnoremap <leader>jd :YcmCompleter GoTo<CR>

nnoremap <leader>yr :YRShow<CR>

" python_fn Shortcuts:
"   ]t      -- Jump to beginning of block
"   ]e      -- Jump to end of block
"   ]v      -- Select (Visual Line Mode) block
"   ]<      -- Shift block to left
"   ]>      -- Shift block to right
"   ]#      -- Comment selection
"   ]u      -- Uncomment selection
"   ]c      -- Select current/previous class
"   ]d      -- Select current/previous function
"   ]<up>   -- Jump to previous line with the same/lower indentation
"   ]<down> -- Jump to next line with the same/lower indentation

" Mark Shortcuts:
"   Highlighting:
"   Normal ,mm  mark or unmark the word under or before the cursor
"          ,mr  manually input a regular expression
"          ,mn  clear current mark (i.e. the mark under the cursor),
"              or clear all marks
"   Visual ,mm  mark or unmark a visual selection
"          ,mr  manually input a regular expression

" Indent-Guides <Leader>ig

" 高亮搜索内容
function! ToggleWrap()
    if &wrap
        set nowrap
        echo 'wrap off'
    else
        set wrap
        echo 'wrap on'
    endif
endfunction


" 高亮搜索内容
function! ToggleHlsearch()
    if &hlsearch
        set nohlsearch
        echo 'hlserach off'
    else
        set hlsearch
        echo 'hlsearch on'
    endif
endfunction

" 高亮当前行当前列
function! TogglePaste()
    if &paste
        set nopaste
        echo 'paste off'
    else
        set paste
        echo 'paste on'
    endif
endfunction

" 高亮当前行当前列
function! ToggleCursorLine()
    if &cursorline
        set nocursorline
        set nocursorcolumn
        echo 'cursorline off'
    else
        set cursorline
        set cursorcolumn
        echo 'cursorline on'
    endif
endfunction

" 自动换工作目录
function! ToggleAutochdir()
    if &autochdir
        set noautochdir
        echo 'autochdir off'
    else
        set autochdir
        echo 'autochdir on'
    endif
endfunction

" 开关鼠标功能和行号，方便在putty里复制
function! ToggleMouse()
    if &mouse == 'a'
        set mouse=
        set nonu
        echo 'mouse off'
    else
        set mouse=a
        set nu
        echo 'mouse on'
    endif
endfunction

" 可视模式下搜索
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"
    let l:pattern = escape(@", '\\/.*$~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    if a:direction == 'b'
        execute "normal ?" . l:pattern . ""
    else
        execute "normal /" . l:pattern . ""
    endif
    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" 查看系统手册
function! ManualSearch()
    let l:saved_reg = @"
    execute "normal! viw"
    execute "normal! vgvy"
    let l:pattern = escape(@", '\\/.*$~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    execute "Man " . l:pattern . ""
    let @" = l:saved_reg
endfunction

function! CleanWhiteSpace()
  exe "normal mz"
  retab
  %s/\s\+$//ge
  %s/^M$//ge
  exe "normal `z"
endfunction

