local M = {}

--@class Keymapper
--@field opts table mapping options
local Keymapper = { default_opts = { noremap = true } }
Keymapper.__index = Keymapper

function Keymapper:new(opts)
  local mapper = setmetatable({}, self)

  mapper.opts = opts

	return mapper
end

function Keymapper:_set_keymap(...)
  return vim.api.nvim_set_keymap(...)
end

--@class BufKeymapper
--@field bufnr buffer number
local BufKeymapper = { bufnr = nil }
BufKeymapper.__index = BufKeymapper
setmetatable(BufKeymapper, { __index = Keymapper })

function BufKeymapper:new(bufnr, opts)
  local mapper = setmetatable({}, self)

  mapper.bufnr = bufnr
  mapper.opts = opts

  return mapper
end

function BufKeymapper:_set_keymap(...)
  return vim.api.nvim_buf_set_keymap(self.bufnr, ...)
end

function Keymapper:get_opts(opts)
	return vim.tbl_extend("force", self.default_opts, self.opts or {}, opts or {})
end

-- Create a key mapping
--@param mode string | list[string] Modes in which to create the mapping
--@param chord string The new key sequence to map
--@param target string What it maps to
--@param opts table | nil Mapping options
function Keymapper:map(modes, chord, target, opts)
	if type(modes) == "string" then
		modes = { modes }
	end

	if type(modes) ~= "table" then
		error "Expected `modes` to a string or a list of strings"
	end

	opts = self:get_opts(opts)
	for _, mode in ipairs(modes) do
    self:_set_keymap(mode, chord, target, opts)
	end
end

-- Map chord to a command.
--
-- Like Keymapper.map, but surrounds `target` with "<Cmd>...<CR>".
function Keymapper:cmd(modes, chord, target, opts)
	self:map(modes, chord, "<Cmd>" .. target .. "<CR>", opts)
end

function M:set_leader(leader)
	vim.g.mapleader = leader
	vim.g.localmapleader = vim.g.mapleader
end

function M:setup()
	-- Map <Leader> to ';' because '\' is just to far away
	M:set_leader ";"

	local keys = Keymapper:new()

	-- Use <Space> to enter command mode
	keys:map({ "n", "v" }, "<Space>", ":")

	-- Navigate half a page up/down with H/L
	keys:map({ "n", "v" }, "H", "<C-u>")
	keys:map({ "n", "v" }, "L", "<C-d>")

	-- Seach visual selection:
	-- y - yank
	-- / - enter search mode
	-- <C-r>" - paste contents of register "
	keys:map("v", "//", [[y/<C-r>"<CR>]])

	-- Disable search highlighting
	keys:cmd("n", "<C-n>", "nohlsearch")

	-- Exit terminal mode by hitting <Esc> twice
	keys:map("t", "<Esc><Esc>", [[<C-\><C-n>]])

	-- Open telescope pickers
	keys:cmd("n", "<Leader>o", [[Telescope git_files]])
	keys:cmd("n", "<Leader>O", [[Telescope find_files]])
	keys:cmd("n", "<Leader>b", [[Telescope buffers]])
	keys:cmd("n", "<Leader>/", [[Telescope live_grep]])

	-- Open file picker in nvim config directory
	function _G.phijor_find_config_files()
		local config_path = vim.api.env.XDG_CONFIG_HOME .. "/nvim/config"
		require("telescope.builtin").find_files { cwd = config_path }
	end
	keys:cmd("n", "<Leader>vo", [[lua phijor_find_config_files()]])
end

return M
