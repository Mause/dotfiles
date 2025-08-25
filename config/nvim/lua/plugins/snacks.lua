return {
  ---@type LazySpec
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    keys = {
      { "<leader>lg", "<CMD>:lua Snacks.lazygit()<CR>", { desc = "[L]azy[G]it" } },
    },
    ---@type snacks.Config
    opts = {
      lazygit = {},
      input = { enabled = true },
    },
  },
}
