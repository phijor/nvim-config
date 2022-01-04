local M = {}

function M:set_leader(leader)
	vim.g.mapleader = leader
	vim.g.localmapleader = vim.g.mapleader
end

function M:setup()
  local KeyMapper = require('phijor.util').KeyMapper

	-- Map <Leader> to ';' because '\' is just to far away
	M:set_leader ";"

  local keys = KeyMapper:new()

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
