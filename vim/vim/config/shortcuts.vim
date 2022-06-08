" leader设置
let mapleader = ","
let g:mapleader = ","

inoremap jk <Esc>
cnoremap jk <C-c>
inoremap Jk <Esc>
cnoremap Jk <C-c>

" 编辑配置文件
nnoremap <Leader>e :e $MYVIMRC<CR>
" 更新配置
nnoremap <Leader>uu :source $MYVIMRC<CR>

" 刷新屏幕
nnoremap <Leader>l <C-L>

" 修改文件换行方式
nnoremap <Leader>fd :set ff=dos<CR>
nnoremap <Leader>fu :set ff=unix<CR>

" 行回绕时移动比较符合直觉
nnoremap j gj
nnoremap k gk

" 有多个窗口时方便移动
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l
nnoremap <C-Up> <C-W>-
nnoremap <C-Down> <C-W>+
nnoremap <C-Left> <C-W><
nnoremap <C-Right> <C-W>>

" 保存文件
nnoremap <Leader>s :w!<CR>

" 标签页
nnoremap <Leader>tn :tabnew %<CR>
nnoremap <Leader>tc :tabclose<CR>
nnoremap <Leader>te :tabedit<CR>:Startify<CR>
nnoremap <Leader>tm :tabmove<Space>

" 空格翻页比较符合习惯
nmap <Space> <C-D>
vmap <Space> <C-D>

" 设置tab宽度
nnoremap <Leader>t2 :set shiftwidth=2<CR>
nnoremap <Leader>t4 :set shiftwidth=4<CR>
nnoremap <Leader>t8 :set shiftwidth=8<CR>

" 选中时缩进
vnoremap > >gv
vnoremap < <gv

" 在命令模式下也能用Bash快捷键
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-B> <Left>
cnoremap <C-F> <Right>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>
cnoremap <C-D> <Del>

" windows全屏
if has('win32')
    nnoremap <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
endif

" 方便远程连接时所有模式关闭鼠标，方便使用鼠标拷贝
nnoremap <Leader>ms :call ToggleMouse()<CR>

" 某些时候自动换目录不方便
" nnoremap <Leader>ad :call ToggleAutochdir()<CR>

" 当前行和列高亮开关
nnoremap <Leader>hc :call ToggleCursorLine()<CR>

" 粘贴模式开关
nnoremap <Leader>ps :call TogglePaste()<CR>

" 搜索高亮开关
nnoremap <Leader>hl :nohlsearch<CR>

" 行尾回绕开关
nnoremap <Leader>nw :call ToggleWrap()<CR>

" buffer相关
nnoremap <Leader>bd :bd!<CR>

" 关闭
nnoremap <Leader>qa :qa<CR>
nnoremap <Leader>qq :q<CR>
nnoremap <Leader>qf :q!<CR>
nnoremap <Leader>qaf :qa!<CR>

nnoremap <Leader>mk :make -j$(grep --count processor /proc/cpuinfo)<CR>

nnoremap <Leader>fs :%!sudo cat > %<CR>

nnoremap <Leader>cw :call CleanWhiteSpace()<CR>

" 设置回绕
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

" 粘贴模式
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

function! CleanWhiteSpace()
  exe "normal mz"
  retab
  %s/\s\+$//ge
  %s/^M$//ge
  exe "normal `z"
endfunction

