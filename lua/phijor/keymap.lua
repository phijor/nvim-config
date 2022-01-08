local M = {}

function M:set_leader(leader)
  vim.g.mapleader = leader
  vim.g.localmapleader = vim.g.mapleader
end

function M:setup()
  local KeyMapper = require("phijor.util").KeyMapper

  -- Map <Leader> to ';' because '\' is just to far away
  M:set_leader ";"

  local keys = KeyMapper:new()

  -- Use <Space> to enter command mode
  keys:map("nv", "<Space>", ":")

  -- Navigate half a page up/down with H/L
  keys:map("nv", "H", "<C-u>")
  keys:map("nv", "L", "<C-d>")

  -- Seach visual selection:
  -- y - yank
  -- / - enter search mode
  -- <C-r>" - paste contents of register "
  keys:map("v", "//", [[y/<C-r>"<CR>]])

  -- Disable search highlighting
  keys:cmd("n", "<C-n>", "nohlsearch")

  -- Exit terminal mode by hitting <Esc> twice
  keys:map("t", "<Esc><Esc>", [[<C-\><C-n>]])

  local function telescope(cmd)
    return require("telescope.builtin")[cmd]
  end

  -- Open telescope pickers
  keys:cmd("n", "<Leader>o", telescope "git_file")
  keys:cmd("n", "<Leader>O", telescope "find_files")
  keys:cmd("n", "<Leader>b", telescope "buffers")
  keys:cmd("n", "<Leader>/", telescope "live_grep")

  -- Open file picker in nvim config directory
  keys:cmd("n", "<Leader>vo", function()
    require("telescope.builtin").find_files { cwd = vim.fn.stdpath "config" }
  end)
end

---Map keys that require autocomands to do so, i.e. filetype-specific keys.
function M:map_keys_autocmd()
  local augroups = require("phijor.util").augroups

  augroups {
    quickfix = {
      -- Exit quickfix and loclist by hitting <Esc> twice
      { "FileType", "qf", "nmap <buffer> <Esc><Esc> <Cmd>lclose<CR>" },
    },
  }
end

---Map keys after attaching langauge server to a buffer.
---@param bufnr integer Buffer to attach to
function M.map_keys_lsp(bufnr)
  local util = require "phijor.util"
  local buf = util.KeyMapper:new { silent = true, buffer = bufnr }

  local lsp = vim.lsp

  buf:maps {
    -- Jump to items
    ["n gd"] = { lsp.buf.definition },
    ["n gD"] = { lsp.buf.declaration },
    ["n gi"] = { lsp.buf.implementation },
    ["n gt"] = { lsp.buf.type_definition },
    ["n gr"] = { lsp.buf.references },

    -- Hovers
    ["ni <C-k>"] = { lsp.buf.signature_help },
    ["n K"] = { lsp.buf.hover },

    -- Workspace actions
    ["n <Leader>wa"] = { lsp.buf.add_workspace_folder },
    ["n <Leader>wr"] = { lsp.buf.remove_workspace_folder },
    ["n <Leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
    },

    -- Navigation
    ["n [d"] = { vim.diagnostic.goto_prev },
    ["n ]d"] = { vim.diagnostic.goto_next },

    -- Interaction
    ["n <Leader>f"] = { lsp.buf.formatting },
    ["v <Leader>f"] = { lsp.buf.range_formatting },
    ["n <Leader>r"] = { lsp.buf.rename },
    ["n <Leader>a"] = { lsp.buf.code_action },

    -- Diagnostics
    ["n <Leader>dl"] = { vim.diagnostic.setloclist },
    ["n <Leader>dL"] = {
      function()
        local namespace = nil
        vim.diagnostic.show(namespace, bufnr)
      end,
    },
    ["n <Leader>ds"] = {
      function()
        vim.diagnostic.open_float { bufnr = bufnr }
      end,
    },
    ["n <Leader>dS"] = {
      function()
        vim.diagnostic.open_float { scope = "buffer", bufnr = bufnr }
      end,
    },

    -- Misc
    ["n <Leader>R"] = { buf.format_cmd "LspRestart" },
  }
end

return M
