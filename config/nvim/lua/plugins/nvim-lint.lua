-- Plugin: mfussenegger/nvim-lint
-- Installed via store.nvim

return {
  "mfussenegger/nvim-lint",
  event = "VeryLazy",
  config = function()
    require("lint").linters_by_ft = {
      ["yaml.ghaction"] = { "actionlint" },
      ["sh"] = { "shellcheck" },
    }

    -- Optionally, you can set up an autocommand to run linting on save
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
