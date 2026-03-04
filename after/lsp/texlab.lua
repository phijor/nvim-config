return {
  root_markers = { '.latexmkrc', 'latexmkrc', '.texlabroot', 'texlabroot', 'Tectonic.toml', '.git' },
  settings = {
    texlab = {
      build = {
        onSave = true,
      },
      forwardSearch = {
        executable = "sioyek",
        args = {
          "--reuse-window",
          "--forward-search-file",
          "%f",
          "--forward-search-line",
          "%l",
          "%p",
        }
      },
      experimental = {
        mathEnvironments = { "diagram", "diagram*" },
      },
    },
  },
}
