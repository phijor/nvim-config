-- vim: ts=2:

vim.cmd [[packadd packer.nvim]]

require("packer").startup(function(use)
  use "wbthomason/packer.nvim"

  use {
    "rcarriga/nvim-notify",
    config = function()
      local notify = require "notify"

      notify.setup {
        stages = "static",
      }

      vim.notify = notify
    end,
  }

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
    "kosayoda/nvim-lightbulb",
    config = function()
      vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'phijor.lsp'.update_lightbulb()]]
    end,
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
    config = function()
      require("fidget").setup { text = { spinner = "dots" } }
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
  use "p00f/nvim-ts-rainbow"

  -- Treesitter: commentstring
  -- Set `commentstring` based on location in file
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- Git changes
  use {
    "lewis6991/gitsigns.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("gitsigns").setup {
        keymaps = {
          -- Default keymap options
          noremap = true,

          ["n ]h"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'" },
          ["n [h"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'" },

          ["n <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
          ["v <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
          ["n <leader>hu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
          ["n <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
          ["v <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
          ["n <leader>hR"] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
          ["n <leader>hp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
          ["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line{full=true}<CR>',
          ["n <leader>hS"] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
          ["n <leader>hU"] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',

          -- Text objects
          ["o ih"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
          ["x ih"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
        },
      }
    end,
  }

  -- Misc highlighting/naviagtion
  use "tpope/vim-surround"
  use "tpope/vim-repeat"
  use "tpope/vim-commentary" -- Comment stuff out
  -- use 'tpope/vim-fugitive'
  use "tpope/vim-unimpaired"
  use "Raimondi/delimitMate"
  use "wellle/targets.vim"
  use "kana/vim-operator-user"

  -- editorconfig support
  use "gpanders/editorconfig.nvim"

  -- Indent highlighting
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup {
        char = vim.opt.fillchars:get().vert or "│",
        space_char_blankline = " ",
        char_highlight_list = {
          "IndentBlankLine"
        },
        show_current_context = true,
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
        quit_key = "q",
      }

      local c1 = function(mode, key, dir, current_line_only, inclusive_jump)
        local opts = string.format(
          [[{direction = require'hop.hint'.HintDirection.%s, current_line_only = %s, inclusive_jump = %s}]],
          dir,
          tostring(current_line_only),
          tostring(inclusive_jump)
        )
        vim.api.nvim_set_keymap(mode, key, string.format([[<cmd>lua require'hop'.hint_char1(%s)<cr>]], opts), {})
      end

      c1("n", "f", "AFTER_CURSOR", true, false)
      c1("n", "F", "BEFORE_CURSOR", true, false)
      c1("o", "f", "AFTER_CURSOR", true, true)
      c1("o", "F", "AFTER_CURSOR", true, true)
      c1("", "t", "AFTER_CURSOR", true, false)
      c1("", "T", "BEFORE_CURSOR", true, false)

      local key = require("phijor.util").KeyMapper:new { silent = true }

      key:maps {
        ["nv gw"] = { cmd = "HopWord" },
        ["nv gW"] = { cmd = "HopWordCurrentLine" },
        ["nv gl"] = { cmd = "HopLineStart" },
        ["nv gL"] = { cmd = "HopLine" },
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
          },
          -- [ [[https?://[^/]+www\.example\.com/]] ] = { takeover = 'never', priority = 1 },
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

  -- Symbol explorer
  use "liuchengxu/vista.vim"

  -- File tree
  use {
    "kyazdani42/nvim-tree.lua",
    requires = {
      {
        "kyazdani42/nvim-web-devicons",
        opt = true, -- for file icons
      },
    },
    config = function()
      vim.g.nvim_tree_show_icons = {
        git = 0,
        folders = 0,
        files = 0,
        folder_arrows = 0,
      }
      require("nvim-tree").setup {}
    end,
  }

  -- Status line (used to be airline)
  use {
    "nvim-lualine/lualine.nvim",
    requires = {
      {
        "kyazdani42/nvim-web-devicons",
        opt = true, -- for file icons
      },
    },
    config = function()
      require "phijor.lualine"
    end,
  }

  -- search using The Silver Searcher -- ag
  use "Numkil/ag.nvim"

  -- Rust
  use {
    "simrat39/rust-tools.nvim",
    requires = {
      { "neovim/nvim-lspconfig" },
      { "nvim-lua/popup.nvim", opt = true },
      { "nvim-lua/plenary.nvim", opt = true },
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
    "phijor/cornelis",
    branch = "custom",
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
