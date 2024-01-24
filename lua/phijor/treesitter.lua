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
  incremental_selection = {
    enable = false,
    keymaps = {
      init_selection = "<Tab>",
      node_incremental = "<Tab>",
      node_decremental = "<S-Tab>",
      scope_incremental = "g<Tab>",
    },
  },
  textobjects = {
    select = {
      enable = false,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@comment.outer",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
      },
    },
    move = {
      enable = false,
      set_jumps = true,
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]]"] = "@class.outer",
        ["]{"] = "@block.outer",
        ["]c"] = "@comment.outer",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]["] = "@class.outer",
        ["]}"] = "@block.outer",
        ["]C"] = "@comment.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[["] = "@class.outer",
        ["[{"] = "@block.outer",
        ["[c"] = "@comment.outer",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[]"] = "@class.outer",
        ["[}"] = "@block.outer",
        ["[C"] = "@comment.outer",
      },
    },
  },
  textsubjects = {
    enable = true,
    prev_selection = '<S-Tab>',
    keymaps = {
      ['<Tab>'] = 'textsubjects-smart',
      -- ['a'] = 'textsubjects-container-outer',
      -- ['i'] = 'textsubjects-container-inner',
    }
  };
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
