local M = {}

function M:show_available_lsp_clients()
  print(vim.inspect(require("lspconfig").available_servers()))
end

---@param event string
---@param pattern string | string[]
---@param cmd string
---@return string
local function format_autocmd(event, pattern, cmd)
  if type(pattern) == "table" then
    pattern = table.concat(pattern, ",")
  end

  return table.concat({ "autocmd! ", event, pattern, cmd }, " ")
end

---@class AugroupDefinition
---@field [1] string #event
---@field [2] string | string[] #pattern
---@field [3] string #command

---@param name string
---@param definitions AugroupDefinition[]
---@return string[]
local function format_augroups(name, definitions)
  local cmds = { "augroup " .. name, "autocmd!" }
  for _, definition in ipairs(definitions) do
    cmds[#cmds+1] = format_autocmd(unpack(definition))
  end
  table.insert(cmds, "augroup END")
  return cmds
end

---@param groups table<string, AugroupDefinition[]>
function M.augroups(groups)
  local cmds = {}
  for name, definitions in pairs(groups) do
    cmds[#cmds+1] = format_augroups(name, definitions)
  end

  vim.cmd(table.concat(vim.tbl_flatten(cmds), "\n"))
end

---@class MapOpts
---@field unique? boolean
---@field nowait? boolean
---@field silent? boolean
---@field script? boolean
---@field expr?   boolean
---@field noremap? boolean

---@class KeyMapper
---@field opts MapOpts
local KeyMapper = { default_opts = { noremap = true } }
KeyMapper.__index = KeyMapper

---@param opts? MapOpts
---@return KeyMapper
function KeyMapper:new(opts)
  local mapper = setmetatable({}, self)

  mapper.opts = opts

  return mapper
end

---@param mode '""' | '"n"' | '"v"' | '"o"' | '"i"' | '"x"' | '"s"' | '"t"' | '"l"' | '"c"'
---@param lhs string
---@param rhs string
---@param opts? MapOpts
function KeyMapper:_set_keymap(mode, lhs, rhs, opts)
  return vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

---@class BufKeyMapper
---@field bufnr integer
local BufKeyMapper = { bufnr = nil }
BufKeyMapper.__index = BufKeyMapper
setmetatable(BufKeyMapper, { __index = KeyMapper })

---@param bufnr integer
---@param opts? MapOpts
---@return BufKeyMapper
function BufKeyMapper:new(bufnr, opts)
  local mapper = setmetatable({}, self)

  mapper.bufnr = bufnr
  mapper.opts = opts

  return mapper
end

function BufKeyMapper:_set_keymap(...)
  return vim.api.nvim_buf_set_keymap(self.bufnr, ...)
end


---@param opts? table<string, boolean>
---@return table<string, boolean>
function KeyMapper:get_opts(opts)
  return vim.tbl_extend("force", self.default_opts, self.opts or {}, opts or {})
end

---@param str string
---@return string[]
local function explode(str)
    local exploded = {}
    for c in string.gmatch(str, ".") do
      exploded[#exploded+1] = c
    end
    return exploded
end

---Create a keymapping for a `chord` of keys.
---@param modes string | string[] #modes in which to create the mapping
---@param chord string #the new key sequence to map
---@param target string #what it maps to
---@param opts? MapOpts #mapping options
function KeyMapper:map(modes, chord, target, opts)
  if type(modes) == "string" then
    modes = explode(modes)
  end

  if type(modes) ~= "table" then
    error "Expected `modes` to a string or a list of strings"
  end

  opts = self:get_opts(opts)
  for _, mode in ipairs(modes) do
    self:_set_keymap(mode, chord, target, opts)
  end
end

--- Map chord to a command.
---
--- Like @see KeyMapper.map, but surrounds `target` with "<Cmd>...<CR>".
---@param modes string | string[]
---@param chord string
---@param target string
---@param opts? MapOpts
function KeyMapper:cmd(modes, chord, target, opts)
  self:map(modes, chord, self.format_cmd(target), opts)
end

function KeyMapper.format_cmd(target)
  return "<Cmd>" .. target .. "<CR>"
end

---@class MapDefinition
---@field [1] string @chord
---@field [2]? MapOpts @arguments

---Map multiple chords at once
---@param maps table<string, MapDefinition>
function KeyMapper:maps(maps)
  for keys, definition in pairs(maps) do
    local modes, chord = string.match(keys, "(%w?)%s+(.*)")
    local target, opts = unpack(definition)
    self:map(modes, chord, target, opts)
  end
end

M.KeyMapper = KeyMapper
M.BufKeyMapper = BufKeyMapper

return M
