return {
  settings = {
    haskell = {
      plugin = {
        tactics = {
          globalOn = true,
          config = {
            hole_severity = "hint",
          },
        },
        ["ghcide-code-actions-fill-holes"] = { globalOn = false },
      },
      formattingProvider = "fourmolu",
    }
  }
}
