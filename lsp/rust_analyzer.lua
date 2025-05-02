return {
  settings = {
    ["rust-analyzer"] = {
      check = { command = "clippy" },
      checkOnSave = true,
      diagnostics = {
        disabled = { "unresolved-proc-macro" }
      },
      procMacro = {
        enable = true,
      },
      lens = {
        enable = true,
        references = { enable = true },
      },
      completion = {
        termSearch = { enable = true },
      },
    },
  },
}
