-- vim: ts=2:
local cmp = require "cmp"
local luasnip = require "luasnip"

require("luasnip.loaders.from_lua").load {
  paths = vim.fn.stdpath "config" .. "/snippets"
}

local kw_pattern = [[[^ \n\t'"(){}:=.!]\+]]

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  preselect = cmp.PreselectMode.None,
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-j>"] = function ()
      luasnip.jump(1)
    end,
    ["<C-k>"] = function ()
      luasnip.jump(-1)
    end,
    ["<C-Space>"] = cmp.mapping.complete {},
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = false,
    },
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
  }, {
    { name = "path" },
    { name = "buffer", option = { keyword_pattern = kw_pattern }, },
    { name = "agda-symbols", },
    { name = "git" },
    { name = "forester" },
  }, {
    { name = "luasnip" }, -- For luasnip users.
    { name = "emoji" },
  }),
}

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources {
    { name = "cmdline" },
    { name = "agda-symbols", },
  },
})

cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources {
    { name = "buffer",
      option = {
        max_indexed_line_length = 200,
        keyword_pattern = kw_pattern,
      },
    },
    { name = "agda-symbols", },
  },
})
