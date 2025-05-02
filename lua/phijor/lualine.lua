local no_separators = { left = "", right = "" }

require("lualine").setup {
  options = {
    theme = "phijor",
    icons_enabled = false,
    component_separators = no_separators,
    section_separators = no_separators,
  },
  sections = {
    lualine_a = {
      "mode",
    },
    lualine_b = {
      "branch",
    },
    lualine_c = {
      {
        "diff",
        -- FIXME: See comment in `colors/phijor.vim`
        diff_color = {
          added    = 'LuaLineDiffAdd',
          modified = 'LuaLineDiffChange',
          removed  = 'LuaLineDiffDelete',
        },
      },
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        diagnostics_color = {
          error = 'LuaLineDiagnosticsError',
          warn  = 'LuaLineDiagnosticsWarn',
          info  = 'LuaLineDiagnosticsInfo',
          hint  = 'LuaLineDiagnosticsHint',
        },
      },
    },
    lualine_x = {
      "encoding",
      { "fileformat", icons_enabled = false },
      { "filetype",   icons_enabled = false },
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  tabline = {
    lualine_a = {
      {
        "buffers",
        icons_enabled = false,
        use_mode_colors = true,
      },
    },
  },
}
