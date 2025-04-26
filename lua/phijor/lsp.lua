local util = require "phijor.util"

local M = {}

---@type table<string, fun(client: vim.lsp.Client, bufnr: number)>
M.on_attach = {
  ["idris2"] = function(_, bufnr)
    local buf = util.KeyMapper:new { silent = true, buffer = bufnr }
    local code_action = util.lazy_mapdef "idris2.code_action"
    local hover = util.lazy_mapdef "idris2.hover"
    local browse = util.lazy_mapdef "idris2.browse"
    local repl = util.lazy_mapdef "idris2.repl"
    local metavars = util.lazy_mapdef "idris2.metavars"

    local filters = vim.tbl_values(require("idris2.code_action").filters)
    local function select_code_actions()
      local params = vim.lsp.util.make_range_params(0, "utf-8")
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

      ["n <Leader>im"] = metavars { "request_all", "Idris: Request all meta-variables" },

      ["n ]g"] = metavars { "goto_next", "Idris: Jump to next hole" },
      ["n [g"] = metavars { "goto_prev", "Idris: Jump to previous hole" },
    }
  end,

  ["ltex_plus"] = function(_, bufnr)
    require("ltex-utils").on_attach(bufnr)
  end,

  ["rust_analyzer"] = function(_, bufnr)
    local buf = util.KeyMapper:new { buffer = bufnr }

    buf:cmd("n", "<Leader>cr", "LspCargoReload")
  end,

  ["texlab"] = function(_, bufnr)
    local buf = util.KeyMapper:new { silent = true, buffer = bufnr }

    buf:maps {
      ["n <Leader>ll"] = { cmd = "LspTexlabBuild" },
      ["n <Leader>lv"] = { cmd = "LspTexlabForward" },
      ["n <Leader>le"] = { cmd = "LspTexlabChangeEnvironment" },
    }
  end,
}

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    require("phijor.keymap").map_keys_lsp(0)
    if client.server_capabilities.document_formatting then
      require("phijor.autocommands").enable_formatting_on_write()
    end

    vim.lsp.set_log_level("off")
    require('vim.lsp.log').set_format_func(vim.inspect)

    local on_attach = M.on_attach[client.name]
    if on_attach then
      on_attach(client, 0)
    end
  end
})

local function setup_idris2()
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
    code_action_post_hook = function()
      vim.cmd [[silent write]]
    end
  }
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

  null_ls.setup {
    sources = {
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.nixfmt,
      null_ls.builtins.formatting.mdformat,
      null_ls.builtins.code_actions.gitsigns.with {
        disabled_filetypes = { "idris2", "lidris2" },
      },
    },
  }
end

function M.setup()
  vim.lsp.config("*", {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    flags = {
      debounce_text_changes = 150,
    },
  })

  vim.lsp.enable {
    "hls",           -- Haskell
    "html",          -- HTML
    "ltex_plus",     -- LTeX spell checking
    "lua_ls",        -- Lua
    "nil_ls",        -- Nix
    "pyright",       -- Python
    "rust_analyzer", -- Rust
    "texlab",        -- LaTeX
    "tinymist",      -- Typst
    "ts_ls",         -- Typescrip
    "vimls",         -- Vim
    "yamlls",        -- YAML
  }

  -- Legacy setup
  setup_idris2()

  setup_signs()
  setup_null_ls()
end

return M
