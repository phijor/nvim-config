-- vim: ts=2:

local nvim_lsp = require "lspconfig"
local lsp_status = require "lsp-status"

local M = {}

local leader = "<localleader>"

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	local function cmd(fcn)
		return "<cmd>lua vim.lsp." .. fcn .. "()<CR>"
	end

	buf_set_keymap("n", "gD", cmd "buf.declaration", opts)
	buf_set_keymap("n", "gd", cmd "buf.definition", opts)
	buf_set_keymap("n", "K", cmd "buf.hover", opts)
	buf_set_keymap("n", "gi", cmd "buf.implementation", opts)
	buf_set_keymap("n", "<C-k>", cmd "buf.signature_help", opts)
	buf_set_keymap("n", leader .. "wa", cmd "buf.add_workspace_folder", opts)
	buf_set_keymap("n", leader .. "wr", cmd "buf.remove_workspace_folder", opts)
	buf_set_keymap("n", leader .. "wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", leader .. "D", cmd "buf.type_definition", opts)
	buf_set_keymap("n", leader .. "r", cmd "buf.rename", opts)
	buf_set_keymap("n", leader .. "q", cmd "buf.code_action", opts)
	buf_set_keymap("n", "gr", cmd "buf.references", opts)
	buf_set_keymap("n", leader .. "e", cmd "diagnostic.show_line_diagnostics", opts)
	buf_set_keymap("n", "[d", cmd "diagnostic.goto_prev", opts)
	buf_set_keymap("n", "]d", cmd "diagnostic.goto_next", opts)
	buf_set_keymap("n", leader .. "l", cmd "diagnostic.set_loclist", opts)
	buf_set_keymap("n", leader .. "f", cmd "buf.formatting", opts)
	buf_set_keymap("n", leader .. "R", "<cmd>LspRestart<CR>", opts)

	lsp_status.on_attach(client)
end

local lsp_get_default_config = function()
	-- Add additional capabilities supported by nvim-cmp
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
	capabilities = vim.tbl_extend("keep", capabilities, lsp_status.capabilities)
	return {
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150,
		},
		capabilities = capabilities,
	}
end

local function setup_default(servers)
	local lsp_default_config = lsp_get_default_config()

	for _, lsp in ipairs(servers) do
		nvim_lsp[lsp].setup(lsp_default_config)
	end
end

local function setup_lua()
	local lua_lsp_lib = "/usr/lib/lua-language-server"

	local runtime_path = vim.split(package.path, ";")
	table.insert(runtime_path, "lua/?.lua")
	table.insert(runtime_path, "lua/?/init.lua")

	local lua_config = lsp_get_default_config()
	lua_config.cmd = { "lua-language-server", "-E", lua_lsp_lib .. "/main.lua" }
	lua_config.settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	}

	nvim_lsp.sumneko_lua.setup(lua_config)
end

local function setup_texlab()
	local texlab_config = lsp_get_default_config()
	local orig_on_attach = texlab_config.on_attach

	texlab_config.on_attach = function(client, bufnr)
		orig_on_attach(client, bufnr)

		local function buf_set_keymap(...)
			vim.api.nvim_buf_set_keymap(bufnr, ...)
		end

		local function bufcmd(cmd)
			return string.format([[<cmd>lua require('lspconfig').texlab['%s'](%d)<CR>]], cmd, bufnr)
		end

		local options = { noremap = true, silent = true }

		buf_set_keymap("n", leader .. "ll", bufcmd "buf_build", options)
		buf_set_keymap("n", leader .. "lv", bufcmd "buf_search", options)
	end

	texlab_config.settings = {
		texlab = {
			build = {
				onSave = true,
				args = {
					"-pdf",
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
	}
	nvim_lsp.texlab.setup(texlab_config)
end

local function setup_lean()
	local config = lsp_get_default_config()
	require("lean").setup {
		lsp = config,
		lsp3 = config,
		mappings = true,
	}
end

local function setup_agda()
	-- if nvim_lsp.agda_ls then
	if true then
		local agda_config = lsp_get_default_config()
		nvim_lsp["agda_ls"].setup(agda_config)
	else
		vim.notify("agda_ls not found", vim.log.levels.Warning)
	end
end

local function setup_idris2()
	local idris_config = lsp_get_default_config()
	local orig_on_attach = idris_config.on_attach

	idris_config.on_attach = function(client, bufnr)
		orig_on_attach(client, bufnr)

		local function buf_set_keymap(...)
			vim.api.nvim_buf_set_keymap(bufnr, ...)
		end

		local function bufcmd(cmd)
			return string.format([[<cmd>lua require('idris2.code_action').%s()<CR>]], cmd)
		end

		local options = { noremap = true, silent = true }

		buf_set_keymap("n", leader .. "is", bufcmd "case_split", options)
	end

	require("idris2").setup {}
end

local function setup_signs()
	-- signs in sign column
	local signs = {
		Error = "🚫",
		Warn = "⚠",
		Hint = "ℹ",
		Information = "ℹ",
	}

	for type, text in pairs(signs) do
		local hl = "LspDiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = text, texthl = hl, numhl = hl })
	end
end

function M:setup()
	setup_default {
		"pyright",
		"vimls",
	}

	setup_lua()
	setup_texlab()
	-- setup_lean()
	setup_agda()

	setup_signs()
end

function M:update_lightbulb()
	require("nvim-lightbulb").update_lightbulb {
		sign = {
			enabled = false,
		},
		status_text = {
			enabled = true,
		},
	}
end

M.lsp_get_default_config = lsp_get_default_config

return M
