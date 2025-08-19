return {
  { "nvim-treesitter/nvim-treesitter", branch = "master", lazy = false, build = ":TSUpdate" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  { "b0o/SchemaStore.nvim" },
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  ---@type LazySpec
  {
    "github/copilot.vim",
    cond = not os.getenv("ATLASSIAN"),
  },
  { "nvim-tree/nvim-tree.lua", opts = {}, dependencies = { "nvim-tree/nvim-web-devicons" } },
  { "linrongbin16/lsp-progress.nvim", opts = {} },
}
