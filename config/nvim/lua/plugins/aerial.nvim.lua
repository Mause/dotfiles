-- Plugin: stevearc/aerial.nvim
-- Installed via store.nvim

---@type LazySpec
return {
  "stevearc/aerial.nvim",
  opts = {},
  keys = {
    { "<leader>la", "<cmd>AerialToggle!<CR>", desc = "Toggle Aerial" },
  },
  -- Optional dependencies
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
}
