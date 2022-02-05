local M = {}

function M:set_leader(leader)
  vim.g.mapleader = leader
  vim.g.localmapleader = vim.g.mapleader
end

local function telescope(builtin, opts)
  return function()
    local success, err = pcall(require("telescope.builtin")[builtin], opts)
    if not success then
      vim.notify(vim.inspect(err), vim.log.levels.ERROR)
    end
  end
end

function M:setup()
  local KeyMapper = require("phijor.util").KeyMapper

  -- Map <Leader> to ';' because '\' is just to far away
  M:set_leader ";"

  local keys = KeyMapper:new()

  keys:maps {
    -- Use <Space> to enter command mode
    ["nv <Space>"] = { ":" },

    -- Navigate half a page up/down with H/L
    ["nv H"] = { "<C-u>" },
    ["nv L"] = { "<C-d>" },
    -- Seach visual selection:
    -- y - yank
    -- / - enter search mode
    -- <C-r>" - paste contents of register "
    ["v //"] = { [[y/<C-r>"<CR>]] },

    -- Disable search highlighting
    ["n <C-n>"] = { cmd = "nohlsearch" },

    -- Exit terminal mode by hitting <Esc> twice
    ["t <Esc><Esc>"] = { [[<C-\><C-n>]] },

    -- Open telescope pickers
    ["n <Leader>o"] = { telescope "git_files" },
    ["n <Leader>O"] = { telescope "find_files" },
    ["n <Leader>b"] = { telescope "buffers" },
    ["n <Leader>/"] = { telescope "live_grep" },

    -- Open file picker in nvim config directory
    ["n <Leader>vo"] = { telescope("find_files", { cwd = vim.fn.stdpath "config" }) },
  }
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
    ["n gd"] = { telescope "lsp_definitions" },
    ["n gD"] = { lsp.buf.declaration },
    ["n gi"] = { telescope "lsp_implementations" },
    ["n gt"] = { telescope "lsp_type_definitions" },
    ["n gr"] = { telescope "lsp_references" },

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
    ["n <Leader>a"] = { telescope "lsp_code_actions" },
    ["v <Leader>a"] = { telescope "lsp_range_code_actions" },

    -- Diagnostics
    ["n <Leader>dl"] = { telescope "diagnostics" },
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
    ["n <Leader>R"] = { cmd = "LspRestart" },
  }
end

return M
