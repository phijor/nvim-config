lua require('config.options')
lua require('config.plugins')
lua require('config.lsp').setup()

runtime config/autocommands.vim
runtime config/highlight.vim
runtime config/keys.vim

command ShowLspClients lua require('config.util').show_available_lsp_clients()

" if !exists('g:vscode')
"     runtime config/coc/init.vim
" endif

if exists('g:started_by_firenvim')
    runtime config/firenvim/init.vim
endif
