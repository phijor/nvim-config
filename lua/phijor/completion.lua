-- vim: ts=2:
local cmp = require "cmp"
local luasnip = require "luasnip"

local _ = require "cmp_emoji"
local _ = require "cmp_buffer"
local _ = require "cmp_cmdline"

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menu,menuone,noselect"

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
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
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    { name = "luasnip" }, -- For luasnip users.
  }, {
    { name = "path" },
    { name = "buffer" },
    { name = "git" },
  }, {
    { name = "emoji" },
  }),
  experimental = {
    ghost_text = true,
  },
}

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources {
    { name = "cmdline" },
  },
})

cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources {
    { name = "buffer" },
  },
})
