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

--@class KeyMapper
--@field opts table mapping options
local KeyMapper = { default_opts = { noremap = true } }
KeyMapper.__index = KeyMapper

function KeyMapper:new(opts)
  local mapper = setmetatable({}, self)

  mapper.opts = opts

  return mapper
end

function KeyMapper:_set_keymap(...)
  return vim.api.nvim_set_keymap(...)
end

--@class BufKeyMapper
--@field bufnr buffer number
local BufKeyMapper = { bufnr = nil }
BufKeyMapper.__index = BufKeyMapper
setmetatable(BufKeyMapper, { __index = KeyMapper })

function BufKeyMapper:new(bufnr, opts)
  local mapper = setmetatable({}, self)

  mapper.bufnr = bufnr
  mapper.opts = opts

  return mapper
end

function BufKeyMapper:_set_keymap(...)
  return vim.api.nvim_buf_set_keymap(self.bufnr, ...)
end

function KeyMapper:get_opts(opts)
  return vim.tbl_extend("force", self.default_opts, self.opts or {}, opts or {})
end

-- Create a key mapping
--@param mode string | list[string] Modes in which to create the mapping
--@param chord string The new key sequence to map
--@param target string What it maps to
--@param opts table | nil Mapping options
function KeyMapper:map(modes, chord, target, opts)
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
-- Like KeyMapper.map, but surrounds `target` with "<Cmd>...<CR>".
function KeyMapper:cmd(modes, chord, target, opts)
  self:map(modes, chord, "<Cmd>" .. target .. "<CR>", opts)
end

M.KeyMapper = KeyMapper
M.BufKeyMapper = BufKeyMapper

return M
