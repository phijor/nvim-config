require("nvim-treesitter.configs").setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
    disable = {
      "agda",
    },
  },
  indent = {
    enable = false,
  },
  rainbow = {
    enable = true,
  },
  incremental_selection = {
    enable = false,
    keymaps = {
      init_selection = "<Tab>",
      node_incremental = "<Tab>",
      node_decremental = "<S-Tab>",
      scope_incremental = "g<Tab>",
    },
  },
}

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.loop = {
  install_info = {
    url = "~/usr/src/tree-sitter/tree-sitter-loop",
    files = {
      "src/parser.c",
    },
  },
  filetype = "loop",
}

parser_config.ld = {
  install_info = {
    url = "~/usr/src/tree-sitter/tree-sitter-ld",
    files = {
      "src/parser.c",
    },
  },
  filetype = "ld",
}

local key = require("phijor.util").KeyMapper:new()

key:maps {
  ["nv <Leader>hg"] = { cmd = "TSHighlightCapturesUnderCursor" },
}
