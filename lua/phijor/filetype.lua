local M = {}

local function setup()
  require("filetype").setup {
    overrides = {
      extensions = {
        -- Agda files
        agda = "agda",
        lagda = "agda",

        -- Idris2 files
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
      literal = {
        [".latexmkrc"] = "perl",
      }
    },
  }
end

M.setup = setup

return M
