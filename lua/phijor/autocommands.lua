local augroups = require("phijor.util").augroups

function highlight_yank()
  require("vim.highlight").on_yank { timeout = 2000 }
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
      { "TextYankPost", "*", highlight_yank },
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
    code_format = {
      { "BufWritePre", "<buffer>", vim.lsp.buf.formatting_sync },
    },
  }

  require("phijor.keymap").map_keys_autocmd()

  M._exists = true
end

return M
