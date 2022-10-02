---Apply Neovide options
---@param opts table<string, any>
local function neovide(opts)
  for key, value in pairs(opts) do
    vim.g["neovide_" .. key] = value
  end
end

neovide {
  cursor_animation_length = 1.0 / 60
}

vim.opt.guifont = "Iosevka_Term:h11"
