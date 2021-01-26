setlocal spell
setlocal conceallevel=2
setlocal wrap
setlocal textwidth=0
setlocal sidescroll=5
setlocal list listchars+=extends:⬎,precedes:↳
setlocal list
setlocal linebreak

nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

nnoremap <Leader>ll :CocCommand latex.Build<CR>
nnoremap <Leader>lc :CocCommand latex.BuildCancel<CR>
nnoremap <Leader>lv :CocCommand latex.ForwardSearch<CR>
