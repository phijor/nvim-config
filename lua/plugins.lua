-- vim: ts=2:

vim.cmd [[packadd packer.nvim]]

require('packer').startup(function (use)
  use 'wbthomason/packer.nvim'

  use 'flazz/vim-colorschemes'

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('treesitter_setup')
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
      local colors = {
        background = '#07111b',
        foreground = '#e3eff8',

        -- normal colors
        black   = '#111c27',
        red     = '#da313b',
        green   = '#32d843',
        yellow  = '#eadb3f',
        blue    = '#3c4ccc',
        magenta = '#cf3e8b',
        cyan    = '#29d9d4',
        white   = '#e3eff8',

        -- bright colors
        bright_black   = '#22313f',
        bright_red     = '#df7074',
        bright_green   = '#74dc7c',
        bright_yellow  = '#dcd87f',
        bright_blue    = '#8d8fe4',
        bright_magenta = '#d97dae',
        bright_cyan    = '#7dc6c5',
        bright_white   = '#83939f',
      }

      local color_template = {
        normal = 'yellow',
        insert = 'green',
        visual = 'magenta',
        replace = 'red',
        command = 'cyan',
        inactive = 'black',
      }

      local color_scheme = {}
      for mode, base in pairs(color_template) do
        color_scheme[mode] = {
          a = {bg = colors[base], fg = colors.black, gui = 'bold'},
          b = {bg = colors.black, fg = colors['bright_' .. base], gui = 'bold'},
          c = {bg = colors.background, fg = colors.white, },
        }
      end

      require('lualine').setup {
        options = {
          theme = color_scheme,
          icons_enabled = true,
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {
            'branch',
            'diff',
            {'diagnostics', sources={'nvim_lsp', 'coc'}}
          },
          lualine_c = {'filename'},
          lualine_x = {
            'encoding',
            { 'fileformat', icons_enabled = false },
            { 'filetype', icons_enabled = false }
          },
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        tabline = {
          lualine_a = {
            {
              'buffers',
              icons_enabled = false,
              buffers_color = {
                active = {bg = colors.yellow, fg = colors.black, gui = nil},
                inactive = {bg = colors.black, fg = colors.white, gui = 'italic'},
              },
            }
          }
        }
      }
    end
  }

  -- search using The Silver Searcher -- ag
  use 'Numkil/ag.nvim'

  -- Rust
  use 'rust-lang/rust.vim'

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
