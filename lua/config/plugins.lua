-- vim: ts=2:

vim.cmd [[packadd packer.nvim]]

require('packer').startup(function (use)
  use 'wbthomason/packer.nvim'

  use 'flazz/vim-colorschemes'

  -- LSP
  use {
    -- 'neovim/nvim-lspconfig',
    -- 'phijor/nvim-lspconfig',
    '~/usr/src/nvim/nvim-lspconfig',
    branch = 'feature-agda-language-server',
    config = function()
      -- require('config.lsp')
    end
  }
  use {
    'nvim-lua/lsp-status.nvim',
    config = function()
      local lsp_status = require('lsp-status')
      lsp_status.register_progress()
      lsp_status.config {
        current_function = true,
        show_filename = false,
        indicator_errors = '✗',
        indicator_warnings = '!',
        indicator_info = 'ℹ',
        indicator_hint = 'ℹ',
        indicator_ok = '✓',
        status_symbol = 'ƒ',
      }
    end
  }
  use {
    'kosayoda/nvim-lightbulb',
    config = function ()
      vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'config.lsp'.update_lightbulb()]]
    end
  }

  -- Autocompletion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      require('config.completion')
    end
  }
  -- Completion sources
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lsp'
  use {
    'davidsierradz/cmp-conventionalcommits',
    filetype = { 'gitcommit' },
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('config.treesitter')
    end
  }
  use 'nvim-treesitter/playground'

  -- Git changes
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup {
        keymaps = {
          -- Default keymap options
          noremap = true,

          ['n ]h'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
          ['n [h'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

          ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
          ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
          ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
          ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
          ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
          ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
          ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
          ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line{full=true}<CR>',
          ['n <leader>hS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
          ['n <leader>hU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',

          -- Text objects
          ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
          ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
        },
      }
    end
  }

  -- Misc highlighting/naviagtion
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  -- use 'tpope/vim-fugitive'
  use 'tpope/vim-unimpaired'
  use 'Raimondi/delimitMate'
  use 'wellle/targets.vim'
  use 'kana/vim-operator-user'

  -- Firenvim browser integration
  use {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end
  }

  -- fuzzy searching
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
    }
  }

  -- Symbol explorer
  use 'liuchengxu/vista.vim'


  -- File tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', opt = true -- for file icons
    }
  }

  -- Status line (used to be airline)
  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons', opt = true
    },
    config = function()
      require('config.lualine')
    end
  }

  -- search using The Silver Searcher -- ag
  use 'Numkil/ag.nvim'

  -- Rust
  use {
    'simrat39/rust-tools.nvim',
    requires = {
      { 'neovim/nvim-lspconfig' },
      { 'nvim-lua/popup.nvim', opt = true },
      { 'nvim-lua/plenary.nvim', opt = true },
      { 'nvim-telescope/telescope.nvim', opt = true },
    },
    ft = {"rust"},
    config = function ()
      local rust_config = require('config.lsp').lsp_get_default_config()
      rust_config.settings = {
        ["rust-analyzer"] = {
          checkOnSave = { command = "clippy" },
          inlayHints = {
            chainingHintsSeparator = "→ ",
            typeHintsSeparator = "⊢ ",
          },
          procMacro = {
            enable = true,
          },
          lens = {
            enable = true,
            methodReferences = true,
          },
        }
      }
      require('rust-tools').setup {
        server = rust_config
      }
    end
  }

  -- Lean
  use 'Julian/lean.nvim'

  -- pass
  use 'https://gitlab.com/craftyguy/vim-redact-pass.git'

  use 'cespare/vim-toml'
end)

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])