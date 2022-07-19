syntax enable " 语法高亮
set guifont=Monaco:h13       " 字体 && 字号

set background=dark
let g:tokyonight_style = "night"
colorscheme tokyonight

" if &term =~ "xterm"
"   " 256位色
"   let &t_Co=256
"   " 退出后恢复现场
"   set t_ti=ESC7ESC[rESC[?47h t_te=ESC[?47lESC8
"   if has("terminfo")
"     let &t_Sf="\ESC[3%p1%dm"
"     let &t_Sb="\ESC[4%p1%dm"
"   else
"     let &t_Sf="\ESC[3%dm"
"     let &t_Sb="\ESC[4%dm"
"   endif
" endif

" highlight Pmenu ctermbg=31
" highlight SpellBad cterm=undercurl,bold ctermbg=0
