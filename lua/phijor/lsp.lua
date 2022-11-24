-- vim: ts=2:

local nvim_lsp = require "lspconfig"

local util = require "phijor.util"

local M = {}

local default_on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  require("phijor.keymap").map_keys_lsp(bufnr)
  if client.server_capabilities.document_formatting then
    require("phijor.autocommands").enable_formatting_on_write()
  end

  vim.diagnostic.config {
    virtual_text = false,
    underline = true,
    severity_sort = true,
    float = {
      source = "always",
    },
  }
end

local lsp_get_default_config = function()
  -- Add additional capabilities supported by nvim-cmp
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
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

  local on_attach = args.on_attach
  args.on_attach = nil

  if on_attach then
    local old_on_attach = config.on_attach

    config.on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      old_on_attach(client, bufnr)
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
        checkOnSave = { command = "clippy" },
        diagnostics = {
          disabled = { "unresolved-proc-macro" }
        },
        procMacro = {
          enable = true,
        },
        lens = {
          enable = true,
          references = { enable = true },
        },
      },
    },
  }

  require("rust-tools").setup {
    tools = {
      inlay_hints = {
        parameter_hints_prefix = "λ ",
        other_hints_prefix = "→ ",
      }
    },
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

      buf:maps {
        ["n <Leader>ll"] = { cmd = "TexlabBuild" },
        ["n <Leader>lv"] = { cmd = "TexlabForward" },
      }
    end,
    settings = {
      texlab = {
        build = {
          onSave = true,
          args = {
            "-rc-report",
            "-pdf",
            "-pdflatex=lualatex",
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

local function setup_idris2()
  local idris_config = get_config {
    on_attach = function(_, bufnr)
      local buf = util.KeyMapper:new { silent = true, buffer = bufnr }
      local code_action = util.lazy_mapdef "idris2.code_action"
      local hover = util.lazy_mapdef "idris2.hover"
      local browse = util.lazy_mapdef "idris2.browse"
      local repl = util.lazy_mapdef "idris2.repl"
      local metavars = util.lazy_mapdef "idris2.metavars"

      local filters = vim.tbl_values(require("idris2.code_action").filters)
      local function select_code_actions()
        local params = vim.lsp.util.make_range_params()
        params["context"] = { diagnostics = {}, only = filters }

        require("telescope.builtin").lsp_code_actions { params = params }
      end

      buf:maps {
        ["n <Leader>is"] = code_action { "case_split", "Idris: Split function argument cases" },
        ["n <Leader>ic"] = code_action { "make_case", "Idris: Create `case` expression" },
        ["n <Leader>iw"] = code_action { "make_with", "Idris: Create `with` clause" },
        ["n <Leader>il"] = code_action { "make_lemma", "Idris: Make a lemma" },
        ["n <Leader>ia"] = code_action { "add_clause", "Idris: Add clause to declaration" },
        ["n <Leader>id"] = code_action { "generate_def", "Idris: Generate definition" },

        ["n <Leader>ie"] = code_action { "expr_search", "Idris: Expression search" },
        ["n <Leader>iE"] = code_action { "expr_search_hints", "Idris: Expression search (+hints)" },

        ["n <Leader>ir"] = code_action { "refine_hole", "Idris: Refine hole" },
        ["n <Leader>iR"] = code_action { "refine_hole_hints", "Idris: Refine hole (with hints)" },

        ["n <Leader>ii"] = code_action { "intro", "Idris: Introduce constructor" },

        ["n <Leader>ib"] = browse { "browse", "Idris: Browse namespace" },
        ["n <Leader>it"] = repl { "evaluate", "Idris: Eval expression in REPL" },

        ["n <Leader>io"] = hover { "open_split", "Idris: Show hovers in split" },
        ["n <Leader>iO"] = hover { "close_split", "Idris: Show hovers in popup" },

        ["n <Leader>iA"] = { select_code_actions, opts = { desc = "Idris show all code actions" } },

        -- TODO: not yet implemented in idris2-lsp 0.5.1
        ["n <Leader>im"] = metavars { "request_all", "Idris: Request all meta-variables" },

        ["n ]g"] = metavars { "goto_next", "Idris: Jump to next hole" },
        ["n [g"] = metavars { "goto_prev", "Idris: Jump to previous hole" },
      }
    end,
  }

  require("idris2").setup {
    client = {
      hover = {
        use_split = true,
        auto_split_size = true,
        split_position = "right",
        with_history = true,
      },
    },
    autostart_semantic = false,
    server = idris_config,
    code_action_post_hook = function()
      vim.cmd [[silent write]]
    end
  }
end

local function setup_haskell()
  local haskell_config = get_config {
    on_attach = function(client, _)
      client.server_capabilities.document_formatting = false
    end,
    settings = {
      haskell = {
        plugin = {
          tactics = {
            globalOn = true,
          }
        }
      }
    }
  }

  nvim_lsp.hls.setup(haskell_config)
end

local function setup_rnix()
  local rnix_config = get_config {}

  nvim_lsp.rnix.setup(rnix_config)
end

local function setup_yamlls()
  local yaml_config = get_config {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
      }
    }
  }
  nvim_lsp.yamlls.setup(yaml_config)
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

local function setup_null_ls()
  local null_ls = require "null-ls"
  local config = get_config {
    sources = {
      null_ls.builtins.formatting.black,
      null_ls.builtins.diagnostics.proselint,
      null_ls.builtins.code_actions.gitsigns.with {
        disabled_filetypes = { "idris2", "lidris2" },
      },
    },
  }

  null_ls.setup(config)
end

function M.setup()
  setup_default {
    "vimls",
    "html",
  }

  setup_python()
  setup_lua()
  setup_rust()
  setup_texlab()
  setup_idris2()
  setup_haskell()
  setup_rnix()
  setup_yamlls()

  setup_signs()
  setup_null_ls()
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
