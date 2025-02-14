local colorscheme = "phijor"

if vim.g.neovide then
  require("phijor.neovide")
  colorscheme = "nightfox"
end

require("phijor.filetype").setup()
require("phijor.keymap").setup()
require "phijor.options"
require "phijor.plugins"
require("phijor.lsp").setup()
require("phijor.autocommands").setup()
require("phijor.completion")

vim.cmd("colorscheme " .. colorscheme)
