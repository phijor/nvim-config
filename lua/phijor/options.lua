local set = vim.opt

---Folds
---#region

-- Provide fold text that ellides folded lines
function _G.phijor_fold_text_ellipsis()
  local foldstart = vim.v.foldstart
  local foldend = vim.v.foldend
  local getline = vim.fn.getline

  local span = foldend - foldstart + 1

  return require('phijor.util').format_fold(
    getline(foldstart),
    getline(foldend),
    span
  )
end

set.foldcolumn = "auto:1"
set.foldmethod = "expr"
set.foldexpr = "nvim_treesitter#foldexpr()"
set.foldtext = "v:lua.phijor_fold_text_ellipsis()"

set.fillchars = {
  foldopen  = "▾",
  foldclose = "▸",
  foldsep   = " ",
  horiz     = '─',
  horizup   = '┴',
  horizdown = '┬',
  vert      = '│',
  vertleft  = '┤',
  vertright = '├',
  verthoriz = '┼',
}
set.foldnestmax = 3
set.foldminlines = 1 -- start with one level of folds opened
---#endregion

-- Splits
--#region
set.laststatus = 3 -- display status line only once
set.splitbelow = true -- split windows below the current window
--#endregion

-- Indentation, insertion
--#region
set.autoindent = true
set.tabstop = 2
set.shiftwidth = 0 -- use value of tabstop
set.softtabstop = -1 -- use value of tabstop
set.shiftround = true -- align indents to shiftwidth
set.expandtab = true
set.wrap = false

set.clipboard:append "unnamedplus"
set.undolevels = 1000
--#endregion

-- Visuals
set.number = true -- show line numbers
set.ruler = true -- show cursor position in status line
set.cursorline = true -- underline the line the cursor is on
set.cursorcolumn = true -- highlight the column the cursor is on
set.errorbells = false -- don't beep/flash on error
set.title = true -- set title of window
set.showmode = false -- do not show "-- {mode} --" messages
set.winborder = "single"

-- Commandline
set.showcmd = true -- show partial command and highlight dimensions
set.history = 50 -- keep 50 liens of command line history
set.shortmess:append "c"
set.wildmenu = true
set.wildmode = { list = "longest" }
-- Suffixes that get lower priority when doing tab completion for filenames.
set.suffixes:append {
  "~",
  ".bak",
  ".swp",
  ".o",
  ".info",
  ".aux",
  ".log",
  ".dvi",
  ".bbl",
  ".blg",
  ".brf",
  ".cb",
  ".ind",
  ".idx",
  ".ilg",
  ".inx",
  ".out",
  ".toc",
  ".png",
  ".jpg",
  ".egg-info",
}
set.wildignore:append ".egg-info"

-- Search
set.ignorecase = true
set.smartcase = true
set.incsearch = true
set.showmatch = true

-- Backup and swap files
--#region
set.backup = false -- do not keep a backup file
set.writebackup = false
set.undofile = true -- keep an undo file (undo changes after closing)

-- Set backup-dir for .*.swp-files
set.directory = vim.env.XDG_RUNTIME_DIR .. "/nvim/swap//"

--#endregion

-- Environment
local remote = [[nvr --remote-tab-wait-silent]]
vim.env.EDITOR = remote
vim.env.VISUAL = remote

-- Diagnostics
vim.diagnostic.config {
  virtual_text = false,
  underline = true,
  severity_sort = true,
  float = {
    source = true,
  },
}
