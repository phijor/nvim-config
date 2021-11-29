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
    normal = 'blue',
    insert = 'green',
    visual = 'yellow',
    replace = 'red',
    command = 'cyan',
    inactive = 'black',
}

local function create_section_highlight(section, mode, hl)
  local hl_section = string.format("_StatusLineSection_%s_%s", section, mode)
  local args = {}
  for k, v in pairs(hl) do
    table.insert(args, k .. '=' .. v)
  end
  vim.cmd(string.format("highlight %s %s", hl_section, table.concat(args, ' ')))
  return hl_section
end

local color_scheme = {}
for mode, base in pairs(color_template) do
  local dark_base = 'dark' .. base
  if base == 'black' then
    dark_base = "black"
  end

  color_scheme[mode] = {
    -- a = {bg = colors[base], fg = colors.black },
    -- b = {bg = colors.black, fg = colors['bright_' .. base], gui = 'bold'},
    -- c = {bg = colors.background, fg = colors['bright_' .. base], },
    a = create_section_highlight('a', mode, { ctermfg='black', ctermbg=dark_base }),
    b = create_section_highlight('b', mode, { ctermfg=base,    ctermbg='black', gui='bold' }),
    c = create_section_highlight('c', mode, { ctermfg=base,    ctermbg='none' }),
  }
end

require('lualine').setup {
    options = {
        theme = color_scheme,
        icons_enabled = true,
    },
    sections = {
      lualine_a = {
        'mode'
      },
      lualine_b = {
        'branch',
        'diff',
        {'diagnostics', sources={'nvim_lsp'}}
      },
      lualine_c = {
        [[require('lsp-status').status()]],
        [[require('nvim-lightbulb').get_status_text()]]
      },
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
            active = create_section_highlight('buffer', 'active', {ctermfg='black', ctermbg='darkblue', gui='italic'}),
            inactive = create_section_highlight('buffer', 'inactive', {ctermfg='white', ctermbg='black'}),
          },
        }
      }
    }
  }
