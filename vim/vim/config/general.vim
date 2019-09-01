set nocompatible   " 与vi不兼容
set history=1024   " 历史记录最高数目
filetype plugin on           " 针对不同的文件类型加载对应的插件
filetype indent on           " 启用自动补全
set autoread       " 文件更新时重新读取
set mouse=a  " 所有模式下都可以用鼠标
"set selectmode=mouse,key " 鼠标和shift加特殊键选区算选择模式，不是可视模式
set clipboard=unnamed,autoselect "选择剪贴板
set nobackup   " 取消自动备份
set nowb
set noswapfile
set backupext=.bak   " 自动备份文件后缀
set autochdir " 设定文件浏览器目录为当前目录
set foldmethod=manual        " 选择代码折叠类型
set nopaste " 粘贴时保留原有格式 --> 关闭了，不然autoclose不能自动补全括号
set wildignorecase "打开文件忽略大小写
set wildignore=*.o,*~,*.pyc  "打开文件、补全文件等时忽略提示这些后缀的文件
set wildignore+=*/.hg/*,*/.svn/*,*/.neocon/*
set tags=./tags;/,tags,./**/tags "查找tags文件路径
set tags+=~/.vim/**/tags

" 记录上次打开文件位置
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
set viminfo^=%
