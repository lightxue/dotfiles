"" Vimwiki设置
"" 设置编码
"let g:vimwiki_w32_dir_enc = 'utf-8'
"" 使用鼠标映射
"let g:vimwiki_use_mouse = 1
"" 不要将驼峰式词组作为 Wiki 词条
"let g:vimwiki_camel_case = 0
"let g:vimwiki_menu = ''
"let g:vimwiki_CJK_length = 1
"let g:wimwiki_menu = ''
"let g:wimwiki_flolding = 1
"" 声明可以在wiki里面使用的HTML标签
"let g:vimwiki_valid_html_tags='b,i,s,u,sub,sup,kbd,br,hr,div,del,code,red,center,left,right,h4,h5,h6,pre'

"" ===============================================
"let wiki_1 = {}
"let wiki_1.path = '~/vimwiki/personal/wiki/'
"let wiki_1.path_html = '~/vimwiki/personal/html/'
"let wiki_1.template_path = '~/vimwiki/personal/template/'
"let wiki_1.template_default = 'template'
"let wiki_1.template_ext = '.html'
"" 还不支持markdown转html
""let wiki_1.syntax = 'markdown'
""css这个设置了没看到效果，只好直接在template里写了
""let wiki_1.css_name = 'style.css'

"" ===============================================
"let wiki_2 = {}
"let wiki_2.path = '~/vimwiki/blog/wiki/'
"let wiki_2.path_html = '~/vimwiki/blog/html/'
"let wiki_2.template_path = '~/vimwiki/blog/template/'
"let wiki_2.template_default = 'template'
"let wiki_2.template_ext = '.html'

"" ===============================================
"let g:vimwiki_list = [wiki_1, wiki_2]

"function! MyVimwikiCR() "{{{
  "let res = vimwiki#lst#kbd_cr()
  "if res == "\<CR>" && g:vimwiki_table_mappings
    "let res = vimwiki#tbl#kbd_cr()
  "endif
  "return res
"endfunction "}}}

"" List and Table <CR> mapping
"autocmd filetype vimwiki inoremap <buffer> <silent> <CR> <C-R>=MyVimwikiCR()<CR><C-R>=AutoPairsReturn()<CR>
