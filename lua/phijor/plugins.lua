-- vim: ts=2:

vim.cmd [[packadd packer.nvim]]

require("packer").startup(function(use)
  use "wbthomason/packer.nvim"

  use "flazz/vim-colorschemes"

  -- LSP
  use {
    -- 'neovim/nvim-lspconfig',
    -- 'phijor/nvim-lspconfig',
    "~/usr/src/nvim/nvim-lspconfig",
    branch = "feature-agda-language-server",
  }
  use {
    "nvim-lua/lsp-status.nvim",
    config = function()
      local lsp_status = require "lsp-status"
      lsp_status.register_progress()
      lsp_status.config {
        current_function = true,
        show_filename = false,
        indicator_errors = "✗",
        indicator_warnings = "!",
        indicator_info = "ℹ",
        indicator_hint = "ℹ",
        indicator_ok = "✓",
        status_symbol = "ƒ",
      }
    end,
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
    config = function()
      local null_ls = require "null-ls"
      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.black,
          null_ls.builtins.diagnostics.proselint,
          null_ls.builtins.code_actions.gitsigns,
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
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-emoji"
  use "hrsh7th/cmp-cmdline"
  use "~/usr/src/nvim/cmp-unicode"
  use {
    "davidsierradz/cmp-conventionalcommits",
    filetype = { "gitcommit" },
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

  -- Treesitter: spell checking
  use {
    "lewis6991/spellsitter.nvim",
    requires = {
      "nvim-treesitter/nvim-treesitter",
      opt = true,
    },
    config = function()
      require("spellsitter").setup()
    end,
  }

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
  -- use 'tpope/vim-fugitive'
  use "tpope/vim-unimpaired"
  use "Raimondi/delimitMate"
  use "wellle/targets.vim"
  use "kana/vim-operator-user"

  -- Window resiszing
  use {
    "beauwilliams/focus.nvim",
    config = function()
      require("focus").setup()
    end,
  }

  use {
    "phaazon/hop.nvim",
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

  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
    },
  }

  -- Symbol explorer
  use "liuchengxu/vista.vim"

  -- File tree
  use {
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons",
      opt = true, -- for file icons
    },
  }

  -- Status line (used to be airline)
  use {
    "nvim-lualine/lualine.nvim",
    requires = {
      "kyazdani42/nvim-web-devicons",
      opt = true,
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
  -- Lean
  use "Julian/lean.nvim"

  -- pass
  use "https://gitlab.com/craftyguy/vim-redact-pass.git"

  use "cespare/vim-toml"
end)

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]
