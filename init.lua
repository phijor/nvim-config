-- Set up Lua module cache
pcall(require, "impatient")

local success, notify = pcall(require, "notify")
if success then
  vim.notify = notify
end

require("phijor.filetype").setup()
require("phijor.keymap").setup()
require "phijor.options"
require "phijor.plugins"
require("phijor.lsp").setup()
require("phijor.autocommands").setup()

vim.cmd [[colorscheme phijor]]
