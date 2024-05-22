-- vim: ts=2:

vim.cmd [[packadd packer.nvim]]

local packer = require("packer")

packer.init {
  snapshot = "Packer.lock",
  snapshot_path = vim.fn.stdpath('config'),
}

packer.startup(function(use)
  use "wbthomason/packer.nvim"

  use "flazz/vim-colorschemes"
  use "EdenEast/nightfox.nvim"

  --

  -- Performance
  -- Lua module caching
  use "lewis6991/impatient.nvim"

  -- LSP
  use {
    "neovim/nvim-lspconfig",
  }
  use {
    "jose-elias-alvarez/null-ls.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
  }
  -- Lsp status messages
  use {
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
  }

  -- Autocompletion
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require "phijor.completion"
    end,
  }
  -- Completion sources
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lsp-signature-help"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-emoji"
  use "hrsh7th/cmp-cmdline"
  use {
    "davidsierradz/cmp-conventionalcommits",
    filetype = { "gitcommit" },
  }
  use {
    "petertriho/cmp-git",
    requires = { "nvim-lua/plenary.nvim" },
    filetype = { "gitcommit" },
    config = function()
      require("cmp_git").setup()
    end
  }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require "phijor.treesitter"
    end,
  }
  use "nvim-treesitter/playground"
  use {
    "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
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
  }

  -- Treesitter: commentstring
  -- Set `commentstring` based on location in file
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- Treesitter: textobjects
  -- Naviate using treesitter-defined textobjects
  use "nvim-treesitter/nvim-treesitter-textobjects"
  use "RRethy/nvim-treesitter-textsubjects"
  use {
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
  }

  -- Git changes
  use {
    "lewis6991/gitsigns.nvim",
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
  }

  -- Diff viewer / merge tool
  use "sindrets/diffview.nvim"

  -- Misc highlighting/naviagtion
  use {
    "kylechui/nvim-surround",
    tag = "*",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-surround').setup {}
    end
  }

  use "tpope/vim-repeat"
  use "tpope/vim-commentary" -- Comment stuff out
  -- use 'tpope/vim-fugitive'
  use "tpope/vim-unimpaired"
  use "m4xshen/autoclose.nvim"
  use "wellle/targets.vim"
  use "kana/vim-operator-user"

  -- editorconfig support
  use "gpanders/editorconfig.nvim"

  -- Indent highlighting
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup {
        indent = {
          char = "▏",
        },
        whitespace = {
          highlight = { "IndentBlankLine" },
        },
        scope = {
          enabled = false,
        },
      }
    end
  }

  -- Window resiszing
  use {
    "beauwilliams/focus.nvim",
    config = function()
      require("focus").setup()
    end,
  }

  -- Restore cursor position
  use {
    "vladdoster/remember.nvim",
    config = function()
      require("remember").setup {}
    end,
  }

  use {
    "phaazon/hop.nvim",
    branch = "v2",
    config = function()
      require("hop").setup {
        keys = "asdghklwertyuiopzxcvbnmfj",
        uppercase_labels = true,
      }

      local key = require("phijor.util").KeyMapper:new { silent = true, remap = true }

      local hop_curline = function(direction, offset)
        local hint = require 'hop.hint'
        return function()
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
  }

  -- Firenvim browser integration
  use {
    "glacambre/firenvim",
    run = function()
      vim.fn["firenvim#install"](0)
    end,
    config = function()
      local augroup = require("phijor.util").augroup

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

      augroup {
        firenvim = {
          "BufEnter",
          "github.com_*.txt",
          [[set filetype=markdown]],
        },
      }
    end,
  }

  -- fuzzy searching
  use "junegunn/fzf"
  use "junegunn/fzf.vim"

  -- Terminal integration
  use {
    "akinsho/toggleterm.nvim",
    tag = "v2.*",
    config = function()
      require("toggleterm").setup {
        shade_terminals = false,
      }
    end,
  }

  -- UI customization
  use { "stevearc/dressing.nvim" }

  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup {
        defaults = {
          file_ignore_patterns = { ".cache" },
          layout_strategy = "vertical",
        },
      }
    end,
  }

  use "nvim-telescope/telescope-symbols.nvim"
  -- Symbol explorer
  use "liuchengxu/vista.vim"

  -- File tree
  use {
    "kyazdani42/nvim-tree.lua",
    requires = {
      -- File icons
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  }

  -- Status line (used to be airline)
  use {
    "nvim-lualine/lualine.nvim",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require "phijor.lualine"
    end,
  }

  -- Rust
  use {
    "simrat39/rust-tools.nvim",
    requires = {
      { "neovim/nvim-lspconfig" },
      { "nvim-lua/popup.nvim",           opt = true },
      { "nvim-lua/plenary.nvim",         opt = true },
      { "nvim-telescope/telescope.nvim", opt = true },
    },
    -- configuration is done in lsp.setup
  }

  -- Idris
  use {
    "ShinKage/idris2-nvim",
    requires = {
      "neovim/nvim-lspconfig",
      "MunifTanjim/nui.nvim",
    },
  }

  -- Agda
  use {
    "isovector/cornelis",
    branch = "master",
    requires = {
      "kana/vim-textobj-user",
      "neovimhaskell/nvim-hs.vim",
      "liuchengxu/vim-which-key",
    },
    setup = function()
      require("phijor.plugins.agda").cornelis_setup()
    end,
    config = function()
      require("phijor.plugins.agda").cornelis_config()
    end,
  }

  -- pass
  use "https://gitlab.com/craftyguy/vim-redact-pass.git"

  -- i3
  use "mboughaba/i3config.vim"

  -- typst
  use {
    "kaarmu/typst.vim",
    ft = { 'typst' },
  }

  -- LTex language server (spell checking)
  use {
    "jhofscheier/ltex-utils.nvim",
    requires = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("ltex-utils").setup {
        dictionary = {
          path = vim.api.nvim_call_function("stdpath", { "state" }) .. "/ltex/",
        }
      }
    end
  }

  -- RON (Rust Object Notation)
  use "ron-rs/ron.vim"

  use "cespare/vim-toml"

  use "ARM9/arm-syntax-vim"
end)

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]
