vim.wo.spell = true
vim.bo.bufhidden = "delete"

require("cmp").setup.buffer {
  sources = require("cmp").config.sources({ { name = "conventionalcommits" } }, { { name = "buffer" } }),
}
