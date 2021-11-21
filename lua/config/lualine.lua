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
                    active = {bg = colors.yellow, fg = colors.black, gui = 'italic'},
                    inactive = {bg = colors.black, fg = colors.white, gui = nil},
                },
            }
        }
    }
}
