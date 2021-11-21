-- vim: ts=2:

vim.cmd [[packadd packer.nvim]]

require('packer').startup(function (use)
  use 'wbthomason/packer.nvim'

  use 'flazz/vim-colorschemes'

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    config = function()
      require('config.lsp')
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
  use 'hrsh7th/cmp-nvim-lsp'

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
      require('gitsigns').setup()
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
  -- use 'rust-lang/rust.vim'
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
      require('rust-tools').setup {
        server = rust_config
      }
    end
  }

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
