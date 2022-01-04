local M = {}

function M:show_available_lsp_clients()
	print(vim.inspect(require("lspconfig").available_servers()))
end

--@param event string
--@param pattern string | list[string]
--@param cmd string
local function format_autocmd(event, pattern, cmd)
	if type(pattern) == "table" then
		pattern = table.concat(pattern, ",")
	end

	return table.concat({ "autocmd! ", event, pattern, cmd }, " ")
end

local function format_augroups(name, definitions)
	local cmds = { "augroup " .. name, "autocmd!" }
	for _, definition in ipairs(definitions) do
		table.insert(cmds, format_autocmd(unpack(definition)))
	end
	table.insert(cmds, "augroup END")
	return cmds
end

--@param groups table<string, table>
function M.augroups(groups)
	local cmds = {}
	for name, definitions in pairs(groups) do
		table.insert(cmds, format_augroups(name, definitions))
	end

	vim.cmd(table.concat(vim.tbl_flatten(cmds), "\n"))
end

return M
