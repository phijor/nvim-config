lua require('plugins')

runtime config/options.vim
runtime config/variables.vim
runtime config/autocommands.vim
runtime config/highlight.vim
runtime config/keys.vim

" if !exists('g:vscode')
"     runtime config/coc/init.vim
" endif

if exists('g:started_by_firenvim')
    runtime config/firenvim/init.vim
endif

function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

command SynStack call <SID>SynStack()
