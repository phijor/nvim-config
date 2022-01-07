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

  -- Open telescope pickers
  keys:cmd("n", "<Leader>o", [[Telescope git_files]])
  keys:cmd("n", "<Leader>O", [[Telescope find_files]])
  keys:cmd("n", "<Leader>b", [[Telescope buffers]])
  keys:cmd("n", "<Leader>/", [[Telescope live_grep]])

  -- Open file picker in nvim config directory
  function _G.phijor_find_config_files()
    require("telescope.builtin").find_files { cwd = vim.fn.stdpath('config') }
  end
  keys:cmd("n", "<Leader>vo", [[lua phijor_find_config_files()]])
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
  local util = require("phijor.util")
  local buf = util.BufKeyMapper:new(bufnr, { noremap = true, silent = true })

  local function lsp(target)
    return buf.format_cmd("lua vim.lsp." .. target .. "()")
  end

  local function diag(target)
    return buf.format_cmd("lua vim.diagnostic." .. target .. "()")
  end

  local cmd = buf.format_cmd

  buf:maps {
    -- Jump to items
    ["n gd"] = { lsp "buf.definition" },
    ["n gD"] = { lsp "buf.declaration" },
    ["n gi"] = { lsp "buf.implementation" },
    ["n gt"] = { lsp "buf.type_definition" },
    ["n gr"] = { lsp "buf.references" },

    -- Hovers
    ["ni <C-k>"] = { lsp "buf.signature_help" },
    ["n K"] = { lsp "buf.hover" },

    -- Workspace actions
    ["n <Leader>wa"] = { lsp "buf.add_workspace_folder" },
    ["n <Leader>wr"] = { lsp "buf.remove_workspace_folder" },
    ["n <Leader>wl"] = { cmd [[lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))]] },

    -- Navigation
    ["n [d"] = { diag "goto_prev" },
    ["n ]d"] = { diag "goto_next" },

    -- Interaction
    ["nv <Leader>f"] = { lsp "buf.formatting" },
    ["n <Leader>r"] = { lsp "buf.rename" },
    ["n <Leader>a"] = { lsp "buf.code_action" },

    -- Diagnostics
    ["n <Leader>dl"] = { diag "setloclist" },
    ["n <Leader>dL"] = { diag "show_line_diagnostics" },

    -- Misc
    ["n <Leader>R"] = { cmd "LspRestart" },
  }
end

return M
