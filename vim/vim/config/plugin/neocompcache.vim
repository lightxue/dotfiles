if has('win32')
    " neocompcache配置
    " 启动vim时打开neocompcache
    let g:neocomplcache_enable_at_startup = 1
    " 当输入有大写字母时大小写敏感
    let g:neocomplcache_enable_smart_case = 1
    " 设置最小补全单词长度
    let g:neocomplcache_min_syntax_length = 3
    " 设置缓冲名
    let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
    " 启动驼峰匹配，比如ArgumentsException能被AE匹配".
    let g:neocomplcache_enable_camel_case_completion = 1
    " 启动下划线匹配，比如public_html能被p_h匹配".
    let g:neocomplcache_enable_underbar_completion = 1

    " 不自动选择第一个
    let g:neocomplcache_enable_auto_select = 0
    " When you input 'ho-a',neocomplcache will select candidate 'a'.
    let g:neocomplcache_enable_quick_match = 1

    " 定义关键字
    if !exists('g:neocomplcache_keyword_patterns')
      let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

    " 一些按键映射
    imap <C-K>     <Plug>(neocomplcache_snippets_expand)
    smap <C-K>     <Plug>(neocomplcache_snippets_expand)
    inoremap <expr><C-G>     neocomplcache#undo_completion()
    inoremap <expr><C-Z>     neocomplcache#undo_completion()
    inoremap <expr><C-L>     neocomplcache#complete_common_string()

    " 回车关闭菜单并保存缩进
    inoremap <silent> <CR> <C-R>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      return neocomplcache#smart_close_popup() . "\<CR>"
    endfunction

    " tab触发补全
    inoremap <expr><Tab>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    " <c-h>, <BS>关闭菜单并删除前一个字条
    inoremap <expr><C-H> neocomplcache#smart_close_popup()."\<C-H>"
    inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-H>"
    inoremap <expr><C-Y>  neocomplcache#close_popup()
    inoremap <expr><C-E>  neocomplcache#cancel_popup()

    " 空格关闭菜单
    inoremap <expr><Space>  pumvisible() ? neocomplcache#close_popup() . "\<Space>" : "\<Space>"

    " 不同语言启动不同补全方式
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

    " 以下配置会比较费时
    if !exists('g:neocomplcache_omni_patterns')
      let g:neocomplcache_omni_patterns = {}
    endif
    let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
    let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

endif
