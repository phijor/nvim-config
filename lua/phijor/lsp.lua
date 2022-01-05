-- vim: ts=2:

local nvim_lsp = require "lspconfig"
local lsp_status = require "lsp-status"

local util = require "phijor.util"

local M = {}

local default_on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

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
    ["n <Leader>dl"] = { diag "set_loclist" },
    ["n <Leader>dL"] = { diag "show_line_diagnostics" },

    -- Misc
    ["n <Leader>R"] = { cmd "LspRestart" },
  }

  lsp_status.on_attach(client)
end

local lsp_get_default_config = function()
  -- Add additional capabilities supported by nvim-cmp
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
  capabilities = vim.tbl_extend("keep", capabilities, lsp_status.capabilities)
  return {
    on_attach = default_on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities,
  }
end

---@class GetConfigArgs
---@field public on_attach? function(client: vim.lsp.client, bufnr: integer) Function to run on attaching to buffer.

---Get the default configuration for a server and customize it.
---@param args GetConfigArgs
---@return table
local get_config = function(args)
  local config = lsp_get_default_config()

  if args.on_attach then
    local old_on_attach = config.on_attach
    local on_attach = args.on_attach
    args.on_attach = nil

    config.on_attach = function(client, bufnr)
      old_on_attach(client, bufnr)
      on_attach(client, bufnr)
    end
  end

  return vim.tbl_extend("force", config, args)
end

local function setup_default(servers)
  local lsp_default_config = lsp_get_default_config()

  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup(lsp_default_config)
  end
end

local function setup_lua()
  local lua_lsp_lib = "/usr/lib/lua-language-server"

  local runtime_path = vim.split(package.path, ";")
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")

  local lua_config = get_config {
    cmd = { "lua-language-server", "-E", lua_lsp_lib .. "/main.lua" },
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  }

  nvim_lsp.sumneko_lua.setup(lua_config)
end

local function setup_texlab()
  local texlab_config = get_config {
    on_attach = function(_, bufnr)
      local buf = util.BufKeyMapper:new(bufnr, { noremap = true, silent = true })
      local cmd = buf.format_cmd

      buf:maps {
        ["n <Leader>ll"] = { cmd "TexlabBuild" },
        ["n <Leader>lv"] = { cmd "TexlabForward" },
      }
    end,
    settings = {
      texlab = {
        build = {
          onSave = true,
          args = {
            "-pdf",
            "-interaction=nonstopmode",
            "-synctex=1",
            "%f",
          },
        },
        auxDirectory = "_target",
        forwardSearch = {
          executable = "zathura",
          args = { "--synctex-forward=%l:1:%f", "%p" },
        },
      },
    },
  }

  nvim_lsp.texlab.setup(texlab_config)
end

local function setup_lean()
  local config = lsp_get_default_config()
  require("lean").setup {
    lsp = config,
    lsp3 = config,
    mappings = true,
  }
end

local function setup_agda()
  -- if nvim_lsp.agda_ls then
  if true then
    local agda_config = lsp_get_default_config()
    nvim_lsp["agda_ls"].setup(agda_config)
  else
    vim.notify("agda_ls not found", vim.log.levels.Warning)
  end
end

local function setup_idris2()
  local idris_config = get_config {
    on_attach = function(_, bufnr)
      local buf = util.BufKeyMapper:new(bufnr, { noremap = true, silent = true })

      local function idris(target)
        return string.format([[<cmd>lua require('idris2.code_action').%s()<CR>]], target)
      end

      buf:maps {
        ["n <Leader>is"] = { idris "case_split" },
      }
    end,
  }

  require("idris2").setup {}
end

local function setup_signs()
  -- signs in sign column
  local signs = {
    Error = "🚫",
    Warn = "⚠",
    Hint = "ℹ",
    Information = "ℹ",
  }

  for type, text in pairs(signs) do
    local hl = "LspDiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = text, texthl = hl, numhl = hl })
  end
end

function M:setup()
  setup_default {
    "pyright",
    "vimls",
  }

  setup_lua()
  setup_texlab()
  -- setup_lean()
  -- setup_agda()

  setup_signs()
end

function M:update_lightbulb()
  require("nvim-lightbulb").update_lightbulb {
    sign = {
      enabled = false,
    },
    status_text = {
      enabled = true,
    },
  }
end

M.lsp_get_default_config = lsp_get_default_config
M.get_config = get_config

return M
