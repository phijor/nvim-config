---@brief
---
--- https://github.com/automattic/harper
---
--- The language server for Harper, the slim, clean language checker for developers.
---
--- See our [documentation](https://writewithharper.com/docs/integrations/neovim) for more information on settings.
---
--- In short, they should look something like this:
--- ```lua
--- vim.lsp.config('harper_ls', {
---   settings = {
---     ["harper-ls"] = {
---       userDictPath = "~/dict.txt"
---     }
---   },
--- })
--- ```

local function get_language_id(_, filetype)
  local mapping = {
    tex = 'latex'
  }

  local language_id = mapping[filetype]
  if language_id then
    vim.notify(("Overriding language_id: %s → %s"):format(filetype, language_id), vim.log.levels.INFO)
    return language_id
  else
    return filetype
  end
end

---@type vim.lsp.Config
return {
  cmd = { 'harper-ls', '--stdio' },
  filetypes = {
    'asciidoc',
    'c',
    'cpp',
    'cs',
    'gitcommit',
    'go',
    'html',
    'java',
    'javascript',
    'lua',
    'markdown',
    'markdown.agda',
    'nix',
    'python',
    'ruby',
    'rust',
    'swift',
    'toml',
    'typescript',
    'typescriptreact',
    'haskell',
    'cmake',
    'typst',
    'php',
    'dart',
    'clojure',
    'sh',
    'tex',
  },
  root_markers = { '.harper-dictionary.txt', '.git' },
  get_language_id = get_language_id,
}
