local augroups = require("phijor.util").augroups

function _G.phijor_highlight_yank()
  require("vim.highlight").on_yank { timeout = 2000 }
end

function _G.phijor_restore_cursor_pos()
  -- Last known position in file is store in the "-mark
  local lastpos = vim.fn.line [['"]]
  if lastpos > 1 and lastpos <= vim.fn.line "$" then
    -- Go to last known position
    vim.cmd [[normal! g'"]]
  end
end

local M = {}
M._exists = nil

function M.setup()
  if M._exists then
    vim.notify("Autocommands already set up!", vim.log.levels.WARN)
    return
  end

  augroups {
    highlight = {
      { "TextYankPost", "*", [[silent! lua phijor_highlight_yank()]] },
      { "InsertEnter", "*", [[match ExtraWhitespace /\s\+\%#\@<!$/]] },
      { "InsertLeave", "*", [[match ExtraWhitespace /\s\+$/]] },
    },
    noundofile = {
      {
        "BufWritePre",
        { "/tmp/*", "/var/tmp/*", vim.env.XDG_RUNTIME_DIR .. "/*", "*/.git/*" },
        [[setlocal noundofile]],
      },
    },
    restore_cursor = {
      { "BufReadPost", "*", [[silent! lua phijor_restore_cursor_pos()]] },
    },
    code_format = {
      { "BufWritePre", "<buffer>", [[lua vim.lsp.buf.formatting_sync()]] },
    },
  }

  M._exists = true
end

return M
