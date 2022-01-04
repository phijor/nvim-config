lua require('phijor.keymap').setup()
lua require('phijor.options')
lua require('phijor.plugins')
lua require('phijor.lsp').setup()

runtime config/autocommands.vim

command ShowLspClients lua require('phijor.util').show_available_lsp_clients()

colorscheme phijor

" if !exists('g:vscode')
"     runtime config/coc/init.vim
" endif

if exists('g:started_by_firenvim')
    runtime config/firenvim/init.vim
endif
