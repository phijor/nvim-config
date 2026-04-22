require("luasnip.loaders.from_lua").load {
  paths = vim.fn.stdpath "config" .. "/snippets"
}

local function show_symbol(cmp)
  cmp.show {
    providers = { "agda_symbols" },
  }
end

--- @type blink.cmp.CompletionConfigPartial
local completion = {
  list = {
    cycle = {
      from_top = true,
      from_bottom = true,
    },
    selection = {
      preselect = false,
      auto_insert = true,
    },
  },
  accept = {
    auto_brackets = {
      enabled = false,
    },
  },
}

require("blink.cmp").setup {
  keymap = {
    preset = 'none',
    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>'] = { 'hide', 'fallback' },
    ["<CR>"] = { "accept", "fallback" },

    ["<Tab>"] = { "select_next", "fallback" },
    ["<S-Tab>"] = { "select_prev", "fallback" },

    ['<C-l>'] = { 'snippet_forward', 'fallback' },
    ['<C-h>'] = { 'snippet_backward', 'fallback' },

    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

    ['<C-i>'] = { 'show_signature', 'hide_signature', 'fallback' },
    ['<C-\\>'] = { show_symbol },
  },
  completion = completion,
  cmdline = {
    completion = completion,
  },
  sources = {
    default = {
      'lsp', 'snippets', 'path',
      'conventional_commits',
      'buffer',
    },
    providers = {
      path = {
        opts = {
          get_cwd = function(_)
            return vim.fn.getcwd()
          end
        },
      },
      agda_symbols = {
        name = 'agda_symbols',
        module = 'blink-agda-symbols',
        enabled = function() return true end,
        opts = {
          extra = {
            ["ltr"] = "◁",
            ["rtr"] = "▷",
            ["rh"] = "↪",
            ["rr"] = "↠",
            ["lrmultimap"] = "⧟",
          }
        }
      },
      conventional_commits = {
        name = 'conventional_commits',
        module = 'blink-cmp-conventional-commits',
        opts = {
          completion = {
            items = {
              { type = 'wip', doc = 'Work in progress' },
            },
          },
        },
      },
    },
  },
  snippets = { preset = 'luasnip' },
  fuzzy = {
    implementation = "prefer_rust_with_warning"
  },
}
