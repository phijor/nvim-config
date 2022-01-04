local M = {}

function M:show_available_lsp_clients()
	print(vim.inspect(require("lspconfig").available_servers()))
end

return M
