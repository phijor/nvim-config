require("phijor.keymap").setup()
require "phijor.options"
require "phijor.plugins"
require("phijor.lsp").setup()
require("phijor.autocommands").setup()

vim.cmd [[colorscheme phijor]]
