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
        -- prompt for return type
        prompt_func_return_type = {
            go = true,
            cpp = true,
            c = true,
            java = true,
        },
        -- prompt for function parameters
        prompt_func_param_type = {
            go = true,
            cpp = true,
            c = true,
            java = true,
        },
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
      -- You can also use below = true here to to change the position of the printf
      -- statement (or set two remaps for either one). This remap must be made in normal mode.
      {
        "<leader>rp",
        function()
          require("refactoring").debug.printf({ below = false })
        end,
        mode = "n",
      },

      -- Print var
      {
        "<leader>rv",
        function()
          require("refactoring").debug.print_var()
        end,
        -- Supports both visual and normal mode
        mode = { "x", "n" },
      },

      {
        "<leader>rc",
        function()
          require("refactoring").debug.cleanup({})
        end,
        -- Supports only normal mode
        mode = "n",
      },
    },
  },
}
