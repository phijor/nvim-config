local M = {}

function M.cornelis_setup()
  vim.g.cornelis_max_size = 10
  vim.g.cornelis_use_global_binary = vim.fn.executable('cornelis')
end

---@type table<string, string>
local bindings = {
  ["^-"] = "⁻",
  ["^+"] = "⁺",
  ["_-"] = "₋",
  ["_+"] = "₊",
  ["ell"] = "ℓ",

  ["cd"] = "·",
  ["ni"] = "∋",

  ["sim"] = "∼",
  ["nsim"] = "≁",

  ["''"] = "″",
  ["'''"] = "‴",

  -- Ratio → ∶ : ← Colon
  [":"] = "∶",

  ["rh"] = "↪",

  -- ["gp"] = "π",
  -- ["Gp"] = "Π",
  ["pi"] = "π",
  ["Pi"] = "Π",

  ["eta"] = "η",

  ["iso"] = "≅",
}

local setup_done = false;

function M.input_mode()
  if setup_done then
    return
  end

  require("phijor.keymap").setup_agda_keys()

  local bind_input = vim.fn['cornelis#bind_input']

  for abbrev, symbol in pairs(bindings) do
    bind_input(abbrev, symbol)
  end
end

function M.cornelis_config()
  local augroups = require('phijor.util').augroups
  augroups {
    Agda = {
      { "BufRead,BufNewFile", { "*.agda", "*.lagda*" }, M.input_mode }
    }
  }
end

return M
