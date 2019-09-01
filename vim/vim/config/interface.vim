set cc=0  " 不高亮任何列
set showcmd " 显示输入的字符
set mousehide " 默认不显示鼠标
set so=0 " 移动时光标最多离底部3行
set ruler " 显示行号和列号
set wildmenu " 加强命令行自动补全
" set cmdheight=1 " 命令行占1行
set nu " 显示行号
set lazyredraw " 减少重绘
set hid " 放弃缓冲区时隐藏而不卸载
set backspace=eol,start,indent
set whichwrap=b,s,<,>,[,] " 使指定的左右移动光标的键在行首或行尾可以移到前一行或者后一行
set ignorecase "搜索时忽略大小写
set smartcase " 如果关键字里有大小写就严格匹配
set incsearch " 搜索时动态调到第一个匹配的位置
set wrapscan " 搜索到文件末时循环到第一个搜索结果
set magic "搜索设置相关，\v \V \m \M，详细看help
set showmatch " 括号匹配暂时跳转
set mat=2 " 配对符号高亮"
set hlsearch " 高亮搜索匹配的结果
let &showbreak = '↪  ' " 折行符

try
    "set switchbuf=usetab " 打开缓冲时在原来的窗口打开
    set stal=1 " 至少有两个标签页时才显示标签栏
catch
endtry

" 每行超过80个的字符用下划线标示
au BufRead,BufNewFile *.asm,*.c,*.cpp,*.java,*.cs,*.sh,*.lua,*.pl,*.pm,*.py,*.rb,*.erb,*.hs,*.vim,*.php,*.js 2match Underlined /.\%81v/

au BufNewFile,BufRead *.jce set filetype=cpp
au BufNewFile,BufRead *.proto set filetype=proto
au BufNewFile,BufRead *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=markdown

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 编码与换行
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ambiwidth=double " 使用 US-ASCII 字符两倍的宽度，帮助识别CJK
set fo+=mB " formatoptions
set ffs=unix,dos,mac " 文件格式支持
set encoding=utf-8 " Vim内部使用编码
" 编码识别顺序
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
" 不同终端使用编码不同
if has("win32")
    set termencoding=gbk
else
    set termencoding=utf-8
endif

" 提示和菜单使用中文
" set langmenu=zh_CN.UTF-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
" language messages zh_CN.utf-8


""""""""""""""""""""""""""""""
" 状态栏设置，有了powerline不再使用
""""""""""""""""""""""""""""""
set laststatus=2 "状态栏有两行
set statusline=\     "初始化为一个空格
set statusline+=%m   "是否被修改
set statusline+=%r   "是否是只读
set statusline+=%h   "是否是帮助文档
set statusline+=%w   "是否是预览窗口
set statusline+=\ %<%F   "文件路径
set statusline+=\ ---\ %<%{getcwd()} "显示当前工作目录,%<表示过长就从该位置收缩
set statusline+=\ %=\    "右对齐
set statusline+=[%{strlen(&ft)?&ft:'none'} "文件类型
set statusline+=,\ %{strlen(&fenc)?&fenc:'none'} "文件类型
set statusline+=,\ %{&fileformat}]  "文件格式
set statusline+=\ \ %l/%L:%c  "行号\总行号:列号
set statusline+=\ \ %b-0x%B\   "字符十进制和十六进制的ASCII值

"set rulerformat=%30(%=%m%r%h%w\ %p%%\ %l:%v\ %{(&fenc!=''?&fenc:&enc).(&ff!='unix'?','.&ff:'')}%<%)
"set statusline=%<%F\ %m%r%h%w%=%p%%\ %l:%v\ %{(&fenc!=''?&fenc:&enc).(&ff!='unix'?','.&ff:'')}
set fillchars=stl:-,stlnc:-
hi StatusLine guifg=orange guibg=NONE gui=none ctermfg=166 ctermbg=none cterm=none term=none
hi StatusLineNC guifg=grey guibg=NONE gui=none ctermfg=grey ctermbg=none cterm=none term=none
"""""""""""""""""""""""""""""""
" 设置缩进
""""""""""""""""""""""""""""""
set expandtab " 插入tab时换成合适数量的空格
set shiftwidth=4 " 缩进一步使用的空格数目
set smarttab " 行首的tab用合适的空白符代替
set tabstop=4 " 文件里tab代表的空格数
set lbr " 打开linebreak
set tw=0 " textwidth, 一行的最大宽度
set list " 显示不可见字符"
set lcs=tab:▸-,trail:⌴ " tab用+---显示，行末空格用-显示
set autoindent " 按语法自动缩进
set smartindent " 开启新行时自动缩进
set cindent " 按C的语法缩进
set wrap  " 到屏幕边会回绕

au BufRead,BufNewFile Makefile* set noexpandtab

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /\s\+$/
