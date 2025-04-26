return {
  root_markers = { 'latexmkrc' },
  settings = {
    texlab = {
      build = {
        executable = "latexmk",
        onSave = true,
        args = {
          "-rc-report",
          "-interaction=nonstopmode",
          "-synctex=1",
          "%f",
        },
      },
      auxDirectory = "_target",
      forwardSearch = {
        executable = "zathura",
        args = { "--synctex-forward=%l:1:%f", "%p" },
      },
    },
  },
}
