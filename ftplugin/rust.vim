nnoremap <buffer><Leader>cf :RustFmt<CR>
vnoremap <buffer><Leader>cf :RustFmtRange<CR>

nnoremap <F4> :Neomake! cargo<CR>

nnoremap <Leader>rr :CocCommand rust-analyzer.run<CR>
nnoremap <leader>do :CocCommand rust-analyzer.openDocs<CR>
nnoremap <leader>sr :CocCommand rust-analyzer.ssr<CR>

setlocal textwidth=100
