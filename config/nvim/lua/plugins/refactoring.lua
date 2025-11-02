return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    config = function()
      require("refactoring").setup({
        show_success_message = true,
      })
      require("telescope").load_extension("refactoring")
    end,
    keys = {
      {
        "<leader>rr",
        function()
          require("telescope").extensions.refactoring.refactors()
        end,
        mode = "v",
        desc = "Select refactor",
      },
    },
  },
}
