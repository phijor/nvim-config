require("nvim-treesitter.configs").setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
  indent = {
    enable = false,
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
