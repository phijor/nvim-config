lua require('phijor.keymap').setup()
lua require('phijor.options')
lua require('phijor.plugins')
lua require('phijor.lsp').setup()
lua require('phijor.autocommands').setup()

command ShowLspClients lua require('phijor.util').show_available_lsp_clients()

colorscheme phijor
