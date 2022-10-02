local M = {}

local function setup()
  vim.filetype.add {
    extension = {
      -- (literate) Agda files
      agda = "agda",
      lagda = "agda",

      -- (literate) Idris files
      idr = "idris2",
      lidr = "idris2",

      -- PulseAudio config files
      pa = "conf",

      -- Ghidra specific files
      slaspec = "slaspec",
      slainc = "slaspec",

      cdefs = "xml",
      ldefs = "xml",
      pspec = "xml",
    },
    filename = {
      [".latexmkrc"] = "perl",
    }
  }
end

M.setup = setup

return M
