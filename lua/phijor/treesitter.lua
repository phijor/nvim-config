local config = require("nvim-treesitter.config")
local installed_parsers = config.get_installed('parsers')

local disabled = { "agda" }

local start = function(bufnr, language)
  if vim.tbl_contains(disabled, language) then
    return
  end

  vim.wo.foldlevel = 99
  vim.wo.foldmethod = "expr"
  vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

  vim.treesitter.start(bufnr, language)
end

-- Install treesitter parsers on demand
--
-- Adapted from:
-- https://github.com/luisdavim/dotfiles/blob/072f118be53ccf63af161005e3d96ac621df16e9/files/config/nvim/init.lua#L299
local install = function(event)
  local bufnr = event.buf
  local filetype = event.match

  if not filetype then return end

  local language = vim.treesitter.language.get_lang(filetype)
  if not language then
    vim.notify("No treesitter parser found for language " .. language, vim.log.levels.WARN)
    return
  end

  -- Skip installation if parser is not available at all
  if not vim.tbl_contains(config.get_available(), language) then
    return
  end

  -- Install the parsers if its available but not present locally
  if not vim.tbl_contains(installed_parsers, language) then
    vim.notify("Installing parser for " .. language, vim.log.levels.INFO)

    require("nvim-treesitter").install({ language }):await(function() start(bufnr, language) end)
    return
  end

  start(bufnr, language)
end

local util = require("phijor.util")
local key = util.KeyMapper:new()

util.augroups {
  treesitter = {
    { "FileType", nil, install }
  },
}

key:maps {
  ["nv <Leader>hg"] = { cmd = "TSHighlightCapturesUnderCursor" },
}
