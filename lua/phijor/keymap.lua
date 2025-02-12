local M = {}

function M:set_leader(leader)
  vim.g.mapleader = leader
  vim.g.localmapleader = vim.g.mapleader
end

local function telescope(builtin, opts)
  return function()
    local success, err = pcall(require("telescope.builtin")[builtin], opts)
    if not success then
      vim.notify(("Error calling telescope builting '%s': %s"):format(builtin, vim.inspect(err)), vim.log.levels.ERROR)
    end
  end
end

function M.setup()
  local util = require "phijor.util"

  -- Map <Leader> to ';' because '\' is just to far away
  M:set_leader ";"

  local keys = util.KeyMapper:new()

  local toggle_term = util.cmd { "ToggleTerm", "Toggle terminal (provided by toggleterm plugin)" }

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

    -- Exit terminal mode by hitting <Esc> twice
    ["t <Esc><Esc>"] = { [[<C-\><C-n>]] },
    ["tn <Leader>t"] = toggle_term,

    -- Open telescope pickers
    ["n <Leader>o"] = { telescope("git_files", { recurse_submodules = true, }) },
    ["n <Leader>O"] = { telescope "find_files" },
    ["n <Leader>b"] = { telescope "buffers" },
    ["n <Leader>/"] = { telescope "live_grep" },

    -- Open file picker in nvim config directory
    ["n <Leader>vo"] = { telescope("git_files", { cwd = vim.fn.stdpath "config" }) },
  }
end

---Map keys that require autocomands to do so, i.e. filetype-specific keys.
function M.map_keys_autocmd()
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
    ["nv <Leader>f"] = { lsp.buf.format },
    ["n <Leader>r"] = { lsp.buf.rename },
    ["nv <Leader>a"] = { lsp.buf.code_action },

    -- Diagnostics
    -- * open diagnostics popup for current buffer
    ["n <Leader>dl"] = { telescope("diagnostics", { bufnr = 0 }) },
    -- * open diagnostics popup for *all* buffers
    ["n <Leader>dL"] = { telescope "diagnostics" },
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
    ["n <Leader>R"] = util.cmd { "LspRestart", "Restart LSP server" },
  }
end

function M.setup_agda_keys()
  local util = require "phijor.util"
  local buf = util.KeyMapper:new { buffer = 0 }

  local rw = "Simplified"
  local rw_force = "Normalised"

  buf:maps {
    ["n <Leader>cl"] = { cmd = "CornelisLoad" },
    ["n <Leader>c?"] = { cmd = "CornelisQuestionToMeta" },
    ["n <Leader>cn"] = { cmd = "CornelisNormalize" },
    ["n <Leader>ucn"] = { cmd = "CornelisNormalize HeadCompute" },
    ["n <Leader>cr"] = { cmd = "CornelisRefine" },
    ["n <Leader>cg"] = { cmd = "CornelisGive" },
    ["n <Leader>cm"] = { cmd = "CornelisElaborate " .. rw },
    ["n <Leader>cs"] = { cmd = "CornelisMakeCase" },
    ["n <Leader>ct"] = { cmd = "CornelisTypeInfer " .. rw },
    ["n <Leader>cct"] = { cmd = "CornelisTypeInfer " .. rw_force },
    ["n <Leader>c,"] = { cmd = "CornelisTypeContext " .. rw },
    ["n <Leader>cc,"] = { cmd = "CornelisTypeContext " .. rw_force },
    ["n <Leader>c."] = { cmd = "CornelisTypeContextInfer " .. rw },
    ["n <Leader>cc."] = { cmd = "CornelisTypeContextInfer " .. rw_force },
    ["n <Leader>cd"] = { cmd = "CornelisGoToDefinition" },
    ["n <Leader>cf"] = { cmd = "CornelisHelperFunc" },

    ["n <Leader>xr"] = { cmd = "CornelisRestart" },
    ["n <Leader>xa"] = { cmd = "CornelisAbort" },

    ["n [g"] = { cmd = "CornelisPrevGoal" },
    ["n ]g"] = { cmd = "CornelisNextGoal" },
  }
end

function M.setup_gitsigns_keys()
  local util = require "phijor.util"
  local gitsigns = require "gitsigns"

  local keys = util.KeyMapper:new()

  keys:maps {
    ["n ]h"] = {
      function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gitsigns.next_hunk() end)
        return '<Ignore>'
      end
    },
    ["n [h"] = {
      function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gitsigns.prev_hunk() end)
        return '<Ignore>'
      end
    },
    ["n <leader>hs"] = { gitsigns.stage_hunk },
    ["v <leader>hs"] = {
      function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end
    },
    ["n <leader>hu"] = { gitsigns.undo_stage_hunk },
    ["n <leader>hr"] = { gitsigns.reset_hunk },
    ["v <leader>hr"] = {
      function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end
    },
    ["n <leader>hR"] = { gitsigns.reset_buffer },
    ["n <leader>hp"] = { gitsigns.preview_hunk },
    ["n <leader>hb"] = { function() gitsigns.blame_line { full = true } end },
    ["n <leader>hS"] = { gitsigns.stage_buffer },
    ["n <leader>hU"] = { gitsigns.reset_buffer_index },

    ["ox ih"] = { ":<C-U>Gitsigns select_hunk<CR>" },
  }
end

function M.setup_forester_keys()
  local util = require "phijor.util"
  local forester = require("forester.commands").commands

  local keys = util.KeyMapper:new()

  keys:maps {
    ["n <leader>vb"] = { forester.browse },
    ["n <leader>vn"] = { forester.new_random },
    ["n <leader>vl"] = { forester.link_new },
    ["n <leader>vt"] = { forester.transclude_new },
  }
end

return M
