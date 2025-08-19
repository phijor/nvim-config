local no_separators = { left = "", right = "" }

local function hide_if(default)
  return function (content, _)
    if (content == default) then
      return nil
    else
      return content
    end
  end
end

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
        "diagnostics",
        sources = { "nvim_diagnostic" },
        diagnostics_color = {
          error = 'DiagnosticsError',
          warn  = 'DiagnosticsWarn',
          info  = 'DiagnosticsInfo',
          hint  = 'DiagnosticsHint',
        },
      },
    },
    lualine_x = {
      { "encoding", icons_enabled = false, fmt = hide_if("utf-8")  },
      {
        "lsp_status",
        ignore_lsp = { "null-ls" },
      },
    },
    lualine_y = {
      { "filetype", icons_enabled = false },
    },
    lualine_z = { "location" },
  },
  tabline = {
    lualine_a = {
      {
        "buffers",
        icons_enabled = false,
        use_mode_colors = true,
        symbols = {
          alternate_file = '⇤ ',
        },
      },
    },
  },
}
