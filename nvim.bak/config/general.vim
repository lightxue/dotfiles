set nocompatible   " 与vi不兼容
set history=1024   " 历史记录最高数目
filetype plugin on           " 针对不同的文件类型加载对应的插件 TODO 不加到lua
filetype indent on           " 启用自动补全 TODO 不加到lua
set autoread       " 文件更新时重新读取
set mouse=a  " 所有模式下都可以用鼠标 TODO 不加到lua
"set selectmode=mouse,key " 鼠标和shift加特殊键选区算选择模式，不是可视模式
set clipboard+=unnamedplus
set nobackup   " 取消自动备份
set nowb
set noswapfile
set backupext=.bak   " 自动备份文件后缀
set noautochdir " 设定文件浏览器目录为当前目录 TODO 不加到lua
set foldmethod=manual        " 选择代码折叠类型 TODO 不加到lua
" set nopaste " 粘贴时保留原有格式 --> 关闭了，不然autoclose不能自动补全括号
set wildignorecase "打开文件忽略大小写
set wildignore=*.o,*~,*.pyc  "打开文件、补全文件等时忽略提示这些后缀的文件
set wildignore+=*/.hg/*,*/.svn/*,*/.neocon/*
