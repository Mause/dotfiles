-- Setup language servers.
local lspconfig = require('lspconfig')
lspconfig.ts_ls.setup {
   cmd = { "node", "/data/data/com.termux/files/usr/bin/typescript-language-server", "--stdio" }
}

