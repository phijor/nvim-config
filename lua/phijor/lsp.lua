-- vim: ts=2:

local nvim_lsp = require "lspconfig"
local lsp_status = require "lsp-status"

local util = require "phijor.util"

local M = {}

local default_on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  require("phijor.keymap").map_keys_lsp(bufnr)

  vim.diagnostic.config {
    underline = true,
    severity_sort = true,
    float = {
      source = "if_many",
    },
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

local function setup_python()
  local python_config = get_config {
    settings = {
      python = {
        analysis = {
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true,
        },
      },
    },
  }

  nvim_lsp.pyright.setup(python_config)
end

local function setup_rust()
  local rust_config = get_config {
    on_attach = function(_, bufnr)
      local buf = util.KeyMapper:new { buffer = bufnr }

      buf:cmd("n", "<Leader>cr", "CargoReload")
    end,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = { command = "check" },
        inlayHints = {
          chainingHintsSeparator = "→ ",
          typeHintsSeparator = "⊢ ",
        },
        procMacro = {
          enable = true,
        },
        lens = {
          enable = true,
          methodReferences = true,
        },
      },
    },
  }

  require("rust-tools").setup {
    server = rust_config,
  }
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
      local buf = util.KeyMapper:new { silent = true, buffer = bufnr }
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
      local buf = util.KeyMapper:new { silent = true, buffer = bufnr }

      local function code_action(target)
        return function()
          return require("idris2.code_action")[target]()
        end
      end

      buf:maps {
        ["n <Leader>is"] = { code_action "case_split" },
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
    "vimls",
  }

  setup_python()
  setup_lua()
  setup_rust()
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
