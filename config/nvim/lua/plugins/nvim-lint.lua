-- Plugin: mfussenegger/nvim-lint
-- Installed via store.nvim

return {
  "mfussenegger/nvim-lint",
  event = "VeryLazy",
  config = function()
    local lint = require("lint")
    lint.linters.spotless = {
      cmd = 'mvn',
      stdin = true,         -- or false if it doesn't support content input via stdin. In that case the filename is automatically added to the arguments.
      append_fname = false, -- Automatically append the file name to `args` if `stdin = false` (default: true)
      args = {
        'spotless:apply',
        "spotless:apply",
        -- "-DspotlessIdeHook=" .. ctx.filename,
        "-DspotlessIdeHookUseStdIn",
        "-DspotlessIdeHookUseStdOut",
        "--quiet",
      },                       -- list of arguments. Can contain functions with zero arguments that will be evaluated once the linter is used.
      stream = 'both',         -- ('stdout' | 'stderr' | 'both') configure the stream to which the linter outputs the linting result.
      ignore_exitcode = false, -- set this to true if the linter exits with a code != 0 and that's considered normal.
    }
    lint.linters_by_ft = {
      ["yaml.ghaction"] = { "actionlint" },
      ["sh"] = { "shellcheck" },
      ["java"] = { "spotless" },
      ["xml"] = { "spotless" },
    }

    -- Optionally, you can set up an autocommand to run linting on save
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
