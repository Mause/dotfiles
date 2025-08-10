---@type LazySpec
return {
  "josephburgess/nvumi",
  dependencies = { {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    ---@type snacks.Config
    opts = {
      lazygit = {}
    }
  } },
  keys = {
    { "<leader>on", "<CMD>Nvumi<CR>", { desc = "[O]pen [N]vumi" } },
  },
  opts = {
    virtual_text = "newline", -- or "inline"
    prefix = " 🚀 ", -- prefix shown before the output
    date_format = "iso", -- or: "uk", "us", "long"
    keys = {
      run = "<CR>", -- run/refresh calculations
      reset = "R", -- reset buffer
      yank = "<leader>y", -- yank output of current line
      yank_all = "<leader>Y", -- yank all outputs
    },
    -- see below for more on custom conversions/functions
    custom_conversions = {},
    custom_functions = {}
  }
}
