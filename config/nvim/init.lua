-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

require("config.lazy")
require("config.mason")
require("config.lspconfig")
require('config.treesitter')

vim.keymap.set("n", "<leader>on", "<CMD>Nvumi<CR>", { desc = "[O]pen [N]vumi" })
vim.keymap.set("n", "<leader>lg", "<CMD>:lua Snacks.lazygit()<CR>", { desc = "[L]azy[G]it" })
