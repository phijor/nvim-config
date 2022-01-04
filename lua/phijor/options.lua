local set = vim.opt

-- Folds
--#region

-- Provide fold text that ellides folded lines
function _G.fold_text_ellipsis()
  local foldstart = vim.v.foldstart
  local foldend = vim.v.foldend

  local spaces = (" "):rep(vim.opt.tabstop:get())
  local line_start = vim.fn.getline(foldstart):gsub("(\t)", spaces)
  local line_end = vim.fn.trim(vim.fn.getline(foldend))
  local lines_folded = foldend - foldstart + 1

  return string.format("%s … %s (%d lines)", line_start, line_end, lines_folded)
end

set.foldmethod = "expr"
set.foldexpr = "nvim_treesitter#foldexpr()"
set.foldtext = "v:lua.fold_text_ellipsis()"

set.fillchars = {
  fold = " ",
  foldopen = "▾",
  foldsep = "│",
  foldclose = "▸",
}
set.foldnestmax = 3
set.foldminlines = 1 -- start with one level of folds opened
--#endregion

-- Splits
--#region
set.fillchars:append "vert:┃"
set.splitbelow = true -- split windows below the current window
--#endregion

-- Indentation, insertion
--#region
set.autoindent = true
set.tabstop = 4
set.shiftwidth = 0 -- use value of tabstop
set.softtabstop = -1 -- use value of tabstop
set.shiftround = true -- align indents to shiftwidth
set.expandtab = true

set.clipboard:append "unnamedplus"
set.undolevels = 1000
--#endregion

-- Visuals
set.number = true -- show line numbers
set.ruler = true -- show cursor position in status line
set.cursorline = true -- underline the line the cursor is on
set.errorbells = false -- don't beep/flash on error
set.title = true -- set title of window

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

-- Misc
-- set.updatetime = 300
set.pyxversion = 3

-- Environment
local remote = [[nvr --remote-tab-wait-silent]]
vim.env.EDITOR = remote
vim.env.VISUAL = remote
