" Tagbar
let g:vista_default_executive = 'nvim_lsp'
let g:vista_sidebar_position = 'vertical topleft'
nnoremap <Leader>tb :Vista!!<CR>

" a.vim
nnoremap <Leader>hh :A<CR>
nnoremap <Leader>av :AV<CR>

let g:mkdp_preview_options = { 'uml': {'server': 'https://plantuml.lightxue.com'} }
nnoremap <Leader>md :MarkdownPreviewToggle<CR>

nnoremap <Leader>ij <CMD>%!jq --indent 4<CR>
vnoremap <Leader>ij :!jq --indent 4<CR>
nnoremap <Leader>is <CMD>%!sqlformat - -rs -k upper<CR>
vnoremap <Leader>is :!sqlformat - -rs -k upper<CR>
