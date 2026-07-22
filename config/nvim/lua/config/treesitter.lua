-- Treesitter Plugin Setup
require("nvim-treesitter").install(
  {
    "diff",
    "gitcommit",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "rust",
    "toml",
    "vim",
    "vimdoc",
  })

vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function() vim.treesitter.start() end,
})

--   auto_install = true,
--   highlight = {
--     enable = true,
--     additional_vim_regex_highlighting = false,
--   },
--   ident = { enable = true },
--   rainbow = {
--     enable = true,
--     extended_mode = true,
--     max_file_lines = nil,
--   },
-- })
