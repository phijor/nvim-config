local cterm = {
  black = 0,
  red = 1,
  green = 2,
  yellow = 3,
  blue = 4,
  magenta = 5,
  cyan = 6,
  gray = 7,
  dark_gray = 8,
  light_red = 9,
  light_gree = 10,
  light_yellow = 11,
  light_blue = 12,
  light_magenta = 13,
  light_cyan = 14,
  white = 15,
}

local template = {
  normal = "blue",
  insert = "green",
  visual = "magenta",
  replace = "red",
  command = "cyan",
}

local theme = {};

for mode, base in pairs(template) do
  theme[mode] = {
    a = { fg = cterm.black, bg = cterm[base] },
    b = { fg = "None", bg = cterm["light_" .. base], gui = "bold" },
    c = { fg = cterm.white, bg = cterm.black },
  }
end

local inactive = {
  fg = "None", bg = cterm.black, gui = "None",
}

theme.inactive = {
  a = inactive,
  b = inactive,
  c = inactive,
}

return theme
