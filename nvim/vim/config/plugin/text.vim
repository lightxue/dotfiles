" vim-easy-align
vmap <Enter> <Plug>(EasyAlign)

" " LeaderF
" let g:Lf_ShortcutF = '<Leader>ff'
" let g:Lf_ShortcutB = '<Leader>fb'
" nnoremap <Leader>fm :LeaderfMru<CR>
" nnoremap <Leader>fl :LeaderfLine<CR>
" nnoremap <Leader>fg :Leaderf! rg --stayOpen -e<Space> ""<Left>
" nnoremap <Leader>fw :<C-U><C-R>=printf("Leaderf! rg --stayOpen -e %s", expand("<cword>"))<CR><CR>
" xnoremap <Leader>fw :<C-U><C-R>=printf("Leaderf! rg --stayOpen -e %s", leaderf#Rg#visual())<CR><CR>

" vim-interestingwords
nnoremap <silent> <Leader>mm :call InterestingWords('n')<cr>
nnoremap <silent> <Leader>mu :call UncolorAllWords()<cr>
