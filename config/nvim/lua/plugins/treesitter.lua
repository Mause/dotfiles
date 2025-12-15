return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master", 
    lazy = false,
    build = ":TSUpdate", 
    config = function()
      incremental_selection = { 
        enable = true, 
        keymaps = { 
          init_selection = "<A-o>", 
          node_incremental = "<A-o>", 
          scope_incremental = "<A-O>",
          node_decremental = "<A-i>",
        }, 
      }, 
    }) end, 
  },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  { "b0o/SchemaStore.nvim" },
  {
    "mrcjkb/rustaceanvim",
    version = "^7", -- Recommended
    lazy = false, -- This plugin is already lazy
    cond = not os.getenv("TERMUX_VERSION"),
  },
  ---@type LazySpec
  {
    "github/copilot.vim",
    version = "1.55.0",
    cond = not os.getenv("ATLASSIAN"),
  },
  { "numToStr/Comment.nvim", opts = {} },
}
