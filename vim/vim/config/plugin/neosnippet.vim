"if has('win32') || exists('g:dev_computer')
    "" 展开snippets
    "imap <C-K>     <Plug>(neosnippet_expand_or_jump)
    "smap <C-K>     <Plug>(neosnippet_expand_or_jump)

    "" 像SuperTab一样操作
    "imap <expr><Tab> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<Tab>"
    "smap <expr><Tab> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<Tab>"

    "" For snippet_complete marker.
    "if has('conceal')
      "set conceallevel=2 concealcursor=i
    "endif

    "let g:neosnippet#enable_snipmate_compatibility = 1
    "let g:neosnippet#snippets_directory = '~/.vim/config/plugin/snippets'
"endif
