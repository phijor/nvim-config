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

" https://www.reddit.com/r/neovim/comments/991kmv/annoying_auto_indentation_in_tex_files/
" setlocal autoindent
" 
" let g:tex_indent_items=0
" let g:tex_indent_and=0
" let g:tex_indent_brace=0
