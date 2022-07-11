syntax enable " 语法高亮
set guifont=Monaco:h13       " 字体 && 字号

set background=dark
" colorscheme molokai_dark
colorscheme gruvbox-material
if has("gui_running")
    set guioptions= " 菜单栏、工具栏等都不要了
    "au GUIEnter * simalt ~x  " 窗口启动时自动最大化
    let psc_style='cool'
endif

" 设置当前行当前列高亮颜色
set nocursorline
set nocursorcolumn
if has("gui_running")
    hi cursorline guibg=#191E2F
    hi CursorColumn guibg=#191E2F
else
    hi cursorline guibg=#191E2F
    hi CursorColumn guibg=#191E2F
endif

if &term =~ "xterm"
  " 256位色
  let &t_Co=256
  " 退出后恢复现场
  set t_ti=ESC7ESC[rESC[?47h t_te=ESC[?47lESC8
  if has("terminfo")
    let &t_Sf="\ESC[3%p1%dm"
    let &t_Sb="\ESC[4%p1%dm"
  else
    let &t_Sf="\ESC[3%dm"
    let &t_Sb="\ESC[4%dm"
  endif
endif

" highlight Pmenu ctermbg=31
" highlight SpellBad cterm=undercurl,bold ctermbg=0
