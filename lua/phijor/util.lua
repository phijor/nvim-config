local M = {}

function M:show_available_lsp_clients()
  print(vim.inspect(require("lspconfig").available_servers()))
end

vim.cmd [[command ShowLspClients lua require('phijor.util').show_available_lsp_clients()]]

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
    cmds[#cmds + 1] = format_autocmd(unpack(definition))
  end
  table.insert(cmds, "augroup END")
  return cmds
end

---@param groups table<string, AugroupDefinition[]>
function M.augroups(groups)
  local cmds = {}
  for name, definitions in pairs(groups) do
    cmds[#cmds + 1] = format_augroups(name, definitions)
  end

  vim.cmd(table.concat(vim.tbl_flatten(cmds), "\n"))
end

---@class MapOpts
---@field buffer? integer
---@field unique? boolean
---@field nowait? boolean
---@field silent? boolean
---@field script? boolean
---@field expr?   boolean
---@field noremap? boolean

---@alias MapTarget string | fun()

---@class KeyMapper
---@field default_opts MapOpts
---@field opts MapOpts
local KeyMapper = { default_opts = {} }
KeyMapper.__index = KeyMapper

---@param opts? MapOpts
---@return KeyMapper
function KeyMapper:new(opts)
  local mapper = setmetatable({}, self)

  mapper.opts = opts

  return mapper
end

---@param opts? MapOpts
---@return MapOpts
function KeyMapper:get_opts(opts)
  return vim.tbl_extend("force", self.default_opts, self.opts or {}, opts or {})
end

---@param str string
---@return string[]
local function explode(str)
  local exploded = {}
  for c in string.gmatch(str, ".") do
    exploded[#exploded + 1] = c
  end
  return exploded
end

---@alias MapMode '""' | '"n"' | '"v"' | '"s"' | '"x"' | '"o"' | '"i"' | '"l"' | '"c"' | '"t"'
local MapMode = {}
MapMode.Default = ""
MapMode.Normal = "n"
MapMode.VisualSelect = "v"
MapMode.Select = "s"
MapMode.Visual = "x"
MapMode.OperatorPending = "o"
MapMode.Insert = "i"
MapMode.InsertCommandLine = "l"
MapMode.CommandLine = "c"
MapMode.Terminal = "t"
MapMode = vim.tbl_add_reverse_lookup(MapMode)


---Create a keymapping for a `chord` of keys.
---@param modes MapMode | MapMode[] #modes in which to create the mapping
---@param chord string #the new key sequence to map
---@param target MapTarget what it maps to
---@param opts? MapOpts #mapping options
function KeyMapper:map(modes, chord, target, opts)
  if type(modes) == "string" then
    modes = explode(modes)
  end

  ---@diagnostic disable-next-line: redundant-parameter
  vim.validate {
    modes = {
      modes,
      function(m)
        for _, mode in ipairs(m) do
          if not MapMode[mode] then
            return false, string.format("%s is not a map mode", vim.inspect(mode))
          end
        end
        return true
      end,
      "map mode or list of map modes",
    },
    chord = { chord, "string" },
    target = { target, { "string", "function" } },
  }

  opts = self:get_opts(opts)
  vim.keymap.set(modes, chord, target, opts)
end

---Sourround a string with "<Cmd>...<CR>"
---@param target string
---@return string
local function format_cmd(target)
  return "<Cmd>" .. target .. "<CR>"
end

--- Map chord to a command.
---
--- Like @see KeyMapper.map, but surrounds `target` with "<Cmd>...<CR>".
---@param modes string | string[]
---@param chord string
---@param target string
---@param opts? MapOpts
function KeyMapper:cmd(modes, chord, target, opts)
  self:map(modes, chord, format_cmd(target), opts)
end

---@class MapDefinition
---@field [1] string target
---@field opts? MapOpts options
---@field cmd? string A command to map via @see KeyMapper.cmd

---@param definition MapDefinition
---@return string | fun()
---@return MapOpts
local function parse_definition(definition)
  local optional = true
  local target = definition[1]
  local cmd = definition.cmd
  local opts = definition.opts

  ---@diagnostic disable-next-line: redundant-parameter
  vim.validate {
    target = { target, { "string", "function" }, optional },
    opts = { opts, "table", optional },
    cmd = { cmd, "string", optional },
  }

  if target and cmd then
    error "`target` and `cmd` are mutually exclusive"
  end

  if cmd then
    return format_cmd(cmd), opts
  elseif target then
    return target, opts
  else
    error "no target given for map"
  end
end

---Map multiple chords at once
---@param maps table<string, MapDefinition>
function KeyMapper:maps(maps)
  for keys, definition in pairs(maps) do
    local function do_map()
      local modes, chord = string.match(keys, "(%w+)%s+(.*)")
      local target, opts = parse_definition(definition)
      self:map(modes, chord, target, opts)
    end

    local success, err = pcall(do_map)
    if not success then
      vim.notify(string.format("Error mapping '%s': %s", keys, vim.inspect(err)), vim.log.levels.ERROR)
    end
  end
end

M.KeyMapper = KeyMapper

---Parse map definition for lazily loaded functions.
---@param definition string | LazyMapDefinition
---@return string, MapOpts
local function parse_lazy_definition(definition)
  ---@diagnostic disable-next-line: redundant-parameter
  vim.validate {
    definition = { definition, { "string", "table" } },
  }

  if type(definition) == "string" then
    return definition, {}
  elseif type(definition) == "table" then
    local optional = true
    ---@diagnostic disable-next-line: redundant-parameter
    vim.validate {
      target = { definition[1], "string", not optional },
      desc = { definition[2], "string", optional },
      opts = { definition.opts, "table", optional },
    }

    local opts = vim.tbl_extend("error", definition.opts or {}, { desc = definition[2] })
    return definition[1], opts
  else
    error "Invalid lazy definition"
  end
end

---@class LazyMapDefinition
---@field [1] string Name of a function to call
---@field [2]? string Description for this definition
---@field opts? MapOpts options
local LazyMapDefinition = {}
M.LazyMapDefinition = LazyMapDefinition

---Create map definitions from a lazily-required module.
---@param module_path string Path to module to lazy-load functions from
---@return fun(definition: string | LazyMapDefinition): MapDefinition
---
--- This function returns a function that takes either takes a string
--- containing the function to call in module `module_path`, or a table
--- with the following keys:
---
--- * `[1]`: Name of the function to call
--- * `[2]`?: Description for this definition
--- * `opts`?: map options
---
--- Instead of writing
---
--- ```lua
--- local keys = KeyMapper.new()
--- keys:map {
---   ["n <Leader>b"] = { function() require("foo").bar() end, opts = { desc = "bar ..." } },
---   ["n <Leader>f"] = { function() require("foo").frob() end, opts = { desc = "frob ..." } },
---   ["n <Leader>q"] = { function() require("foo").qux() end },
--- }
--- ```
--- call the returned function to create an equivalent map definition:
---
--- ```lua
--- local keys = KeyMapper.new()
--- local foo = lazy_mapdef "foo"
--- keys:map {
---   ["n <Leader>b"] = foo { "bar", "bar ..." },
---   ["n <Leader>f"] = foo { "frob", "frob ..." },
---   ["n <Leader>q"] = foo "qux",
--- }
--- ```
function M.lazy_mapdef(module_path)
  ---@diagnostic disable-next-line: redundant-parameter
  vim.validate {
    module_path = { module_path, "string" },
  }

  local function create_def(definition)
    ---@diagnostic disable-next-line: redundant-parameter
    local target, opts = parse_lazy_definition(definition)

    return {
      function()
        require(module_path)[target]()
      end,
      opts = opts,
    }
  end

  return create_def
end

return M
