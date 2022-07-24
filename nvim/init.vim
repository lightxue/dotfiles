set backupcopy=yes

source ~/.config/nvim/config/bundle.vim " 先装插件，保证自定义配置优先级
source ~/.config/nvim/config/color.vim
source ~/.config/nvim/config/general.vim
source ~/.config/nvim/config/interface.vim
source ~/.config/nvim/config/shortcuts.vim
runtime! config/plugin/**/*.vim
" ~/.config/nvim/config/plugin/

" ~/.config/nvim/lua
lua require('completion')
lua require('editor')
lua require('text')
lua require('file-sys')
lua require('language')
lua require('ui')
lua require('misc')

" vim:set expandtab shiftwidth=4 tabstop=4:
