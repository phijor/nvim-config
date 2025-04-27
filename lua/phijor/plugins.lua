-- vim: ts=2:

local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  ---@diagnostic disable-next-line: undefined-field
  if not (vim.uv or vim.loop).fs_stat(pckr_path) then
    vim.fn.system({
      'git',
      'clone',
      "--filter=blob:none",
      'https://github.com/lewis6991/pckr.nvim',
      pckr_path
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

local pckr = require('pckr')

pckr.add {
  "flazz/vim-colorschemes",
  "EdenEast/nightfox.nvim",

  -- LSP
  {
    "neovim/nvim-lspconfig",
  },
  {
    "nvimtools/none-ls.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
  },
  -- Lsp status messages
  {
    "j-hui/fidget.nvim",
    tag = "*",
    config = function()
      require("fidget").setup {
        progress = {
          suppress_on_insert = true,
          ignore = { "ltex" },
        },
      }
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    requires = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
  },
  -- Completion sources
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-emoji",
  "hrsh7th/cmp-cmdline",
  "phijor/cmp-agda-symbols",
  {
    "davidsierradz/cmp-conventionalcommits",
    filetype = { "gitcommit" },
  },
  {
    "petertriho/cmp-git",
    requires = { "nvim-lua/plenary.nvim" },
    filetype = { "gitcommit" },
    config = function()
      require("cmp_git").setup {}
    end
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require "phijor.treesitter"
    end,
  },
  "nvim-treesitter/playground",

  {
    "https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git",
    tag = "*",
    config = function()
      require('rainbow-delimiters.setup').setup {
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          -- 'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
        query = {
          [''] = 'rainbow-delimiters',
          ['latex'] = 'rainbow-blocks',
        },
      }
    end
  },

  -- Treesitter: commentstring
  -- Set `commentstring` based on location in file
  "JoosepAlviste/nvim-ts-context-commentstring",

  -- Treesitter: textobjects
  -- Naviate using treesitter-defined textobjects
  "nvim-treesitter/nvim-treesitter-textobjects",
  "RRethy/nvim-treesitter-textsubjects",
  {
    "mfussenegger/nvim-treehopper",
    config = function()
      local key = require("phijor.util").KeyMapper:new { silent = true }

      local move = function(side)
        return function()
          require('tsht').move { side = side }
        end
      end

      key:maps {
        ["ox m"] = { require('tsht').nodes },
        ["n m"] = { move 'end' },
        ["n M"] = { move 'start' },
      }
    end
  },

  -- Git changes
  {
    "lewis6991/gitsigns.nvim",
    tag = "*",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("gitsigns").setup {
        on_attach = function()
          require("phijor.keymap").setup_gitsigns_keys()
        end
      }
    end,
  },

  -- Diff viewer / merge tool
  "sindrets/diffview.nvim",

  -- Misc highlighting/naviagtion
  {
    "kylechui/nvim-surround",
    tag = "*",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-surround').setup {}
    end
  },

  "tpope/vim-repeat",
  "tpope/vim-commentary", -- Comment stuff out
  "tpope/vim-unimpaired",
  "m4xshen/autoclose.nvim",
  "wellle/targets.vim",
  "kana/vim-operator-user",

  -- Indent highlighting
  {
    "lukas-reineke/indent-blankline.nvim",
    tag = "*",
    config = function()
      require("ibl").setup {
        indent = {
          char = "▏",
        },
        scope = {
          enabled = false,
        },
      }
    end
  },

  -- Window resiszing
  {
    "beauwilliams/focus.nvim",
    config = function()
      require("focus").setup()
    end,
  },

  -- Restore cursor position
  {
    "vladdoster/remember.nvim",
    config = function()
      require("remember").setup {}
    end,
  },

  {
    "smoka7/hop.nvim",
    tag = "v2.*",
    config = function()
      require("hop").setup {
        keys = "asdghklwertyuiopzxcvbnmfj",
        uppercase_labels = true,
      }

      local key = require("phijor.util").KeyMapper:new { silent = true, remap = true }

      local hop_curline = function(direction, offset)
        local hint = require 'hop.hint'
        return function()
          ---@diagnostic disable-next-line: missing-fields
          require("hop").hint_char1 {
            direction = hint.HintDirection[direction],
            current_line_only = true,
            hint_offset = offset,
          }
        end
      end

      key:maps {
        ["nxo f"] = { hop_curline("AFTER_CURSOR", 0) },
        ["nxo F"] = { hop_curline("BEFORE_CURSOR", 0) },
        ["nxo t"] = { hop_curline("AFTER_CURSOR", -1) },
        ["nxo T"] = { hop_curline("BEFORE_CURSOR", 1) },
        ["nv gw"] = { cmd = "HopWord" },
        ["nv gW"] = { cmd = "HopWordCurrentLine" },
        ["nv gl"] = { cmd = "HopLineStart" },
        ["nv gL"] = { cmd = "HopLine" },
        ["n g/"] = { cmd = "HopPattern" },
      }
    end,
  },

  -- Firenvim browser integration
  {
    "glacambre/firenvim",
    run = function()
      vim.fn["firenvim#install"](0)
    end,
    config_pre = function()
      if not vim.g.started_by_firenvim then
        return
      end

      vim.g.firenvim_config = {
        globalSettings = {
          alt = "all",
        },
        localSettings = {
          [".*"] = {
            cmdline = "neovim",
            content = "text",
            takeover = 'never'
          },
        },
      }

      local augroups = require("phijor.util").augroups
      augroups {
        firenvim = {
          { "BufEnter", "github.com_*.txt", [[set filetype=markdown]], },
        },
      }
    end,
  },

  -- fuzzy searching
  "junegunn/fzf",
  "junegunn/fzf.vim",

  -- Terminal integration
  {
    "akinsho/toggleterm.nvim",
    tag = "v2.*",
    config = function()
      require("toggleterm").setup {
        shade_terminals = false,
      }
    end,
  },

  -- UI customization
  "stevearc/dressing.nvim",

  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    requires = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup {
        defaults = {
          file_ignore_patterns = { ".cache", "build" },
          layout_strategy = "vertical",
        },
      }
    end,
  },

  "nvim-telescope/telescope-symbols.nvim",

  -- Buffer based file explorer
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup()
    end,
  },

  -- Status line (used to be airline)
  {
    "nvim-lualine/lualine.nvim",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require "phijor.lualine"
    end,
  },

  -- Idris
  {
    "idris-community/idris2-nvim",
    requires = {
      "neovim/nvim-lspconfig",
      "MunifTanjim/nui.nvim",
    },
  },

  -- Agda
  {
    "phijor/cornelis",
    branch = "v2.7.0-backport",
    requires = {
      "kana/vim-textobj-user",
      "neovimhaskell/nvim-hs.vim",
      "liuchengxu/vim-which-key",
    },
    config_pre = function()
      require("phijor.plugins.agda").cornelis_setup()
    end,
    config = function()
      require("phijor.plugins.agda").cornelis_config()
    end,
  },

  -- i3
  "mboughaba/i3config.vim",

  -- typst
  {
    "kaarmu/typst.vim",
    ft = { 'typst' },
  },

  -- LTex language server (spell checking)
  {
    "phijor/ltex-utils.nvim",
    branch = "downstream-fixes",
    requires = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("ltex-utils").setup {
        ---@diagnostic disable-next-line: missing-fields
        diagnostics = {
          debounce_time_ms = 2000,
        },
      }
    end
  },

  -- Forester
  {
    "phijor/forester.nvim",
    branch = "completion-enhancements",
    requires = {
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("forester").setup()
      require("phijor.keymap").setup_forester_keys()
    end,
  },

  "cespare/vim-toml",

  "ARM9/arm-syntax-vim",
}
