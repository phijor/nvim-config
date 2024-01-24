local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
-- local l = extras.lambda
local rep = extras.rep
-- local p = extras.partial
-- local m = extras.match
-- local n = extras.nonempty
-- local dl = extras.dynamic_lambda
-- local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local conds = require("luasnip.extras.expand_conditions")
-- local postfix = require("luasnip.extras.postfix").postfix
-- local types = require("luasnip.util.types")
-- local parse = require("luasnip.util.parser").parse_snippet
-- local ms = ls.multi_snippet
-- local k = require("luasnip.nodes.key_indexer").new_key

local function wss(context, nodes, opts)
  local pattern_opts = vim.tbl_deep_extend("keep", opts or {}, { trigEngine = "pattern" })
  local pattern_context = "^%s*" .. context
  return s(pattern_context, nodes, pattern_opts)
end

local function get_module_path()
  -- Path to file, relative to current dir, without extension, '/' replaced by '.'
  return vim.fn.expand([[%:.:r]]):gsub('/', '.')
end

local module =
    wss("module", {
      t "module ",
      i(1, "_"),
      t " where",
      t "",
    })

local topmodule =
    wss("topmodule", {
      t "module ", f(get_module_path), t " where",
      t "",
    })

local function hole_node()
  return {
    t "{! ",
    i(1, "_"),
    t " !}",
  }
end

local hole = s("?", hole_node(), {
  descr = "Insert a typed hole"
})

local def =
    wss("def", {
        i(1, "_"), t " : ", sn(2, hole_node()), t { "", "" },
        rep(1), t " = ", sn(3, hole_node()),
      },
      {
        descr = "Insert a function declaration and definition"
      }
    )

local decl =
    s("decl", {
        i(1, "_"), t " : ", sn(2, hole_node())
      },
      {
        descr = "Insert a function declaration"
      }
    )

local record =
    wss("record",
      {
        t "record ", i(1), t " : ", i(2, "Type"), t { " where", "" },
      },
      {
        descr = "Insert a record declaration"
      }
    )

local data =
    wss("data",
      {
        t "data ", i(1), t " : ", i(2, "Type"), t { " where", "" },
      },
      {
        descr = "Insert a data declaration"
      }
    )

local open_import =
    wss("oimp",
      {
        t "open import ", i(0), t { "", "" }
      }
    )


local snippets = {
  topmodule,
  module,
  def,
  decl,
  hole,
  record,
  data,
  open_import,
}

return snippets
