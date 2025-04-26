return {
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = { command = "clippy" },
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
