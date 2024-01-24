-- Set up Lua module cache
pcall(require, "impatient")

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

vim.cmd("colorscheme " .. colorscheme)
