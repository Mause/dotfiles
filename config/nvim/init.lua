-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

function dump(filename, obj)
  local test = assert(io.open(filename .. ".json", "w"))
  local result = vim.json.encode(obj)
  result = vim.system({ 'jq', '--sort-keys' }, { stdin = result }):wait()
  test:write(result.stdout)
  test:close()
end

require("config.lazy")
require("config.mason")
require("config.lspconfig")
require('config.treesitter')
require('config.dap')

