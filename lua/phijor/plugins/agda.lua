local M = {}

function M.cornelis_setup()
  vim.g.cornelis_max_size = 10
  vim.g.cornelis_use_global_binary = vim.fn.executable('cornelis')
  vim.g.cornelis_no_agda_input = true
end

---@type table<string, string>
local bindings = {
  ["^^"] = "˘",

  ["cd"] = "·",
  ["ni"] = "∋",

  ["sim"] = "∼",
  ["nsim"] = "≁",

  ["''"] = "″",
  ["'''"] = "‴",

  ["par"] = "∂",

  -- Ratio → ∶ : ← Colon
  [":"] = "∶",

  ["rh"] = "↪",
  ["rr"] = "↠",

  ["vd"] = "⊢",
  ["vt"] = "ⸯ",

  ["eta"] = "η",

  ["iso"] = "≅",

  ["sq"] = "□",

  ["Ci"] = "◯",

  -- half-width: "ﾖ",
  ["yo"] = "よ",

  ["cup"] = "⌣",

  ["ltr"] = "◁",
  ["rtr"] = "▷",
}

function M.input_mode()
  if vim.b.phijor_agda_setup_done then
    return
  end

  require("phijor.keymap").setup_agda_keys()

  vim.b.phijor_agda_setup_done = true
end

function M.close_info_windows()
  vim.cmd [[:CornelisCloseInfoWindows]]
end

function M.cornelis_config()
  local augroups = require('phijor.util').augroups
  augroups {
    Agda = {
      { { "BufRead", "BufNewFile" }, { "*.agda", "*.lagda*" }, M.input_mode },
      { { "QuitPre" }, { "*.agda", "*.lagda*" }, M.close_info_windows }
    }
  }
end

return M
