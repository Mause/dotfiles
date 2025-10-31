return {
  ---@type lazy.LazySpec
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    keys = {
      { "<leader>lg", "<CMD>:lua Snacks.lazygit()<CR>", { desc = "[L]azy[G]it" } },
      { "<leader>tm", "<CMD>:lua Snacks.terminal()<CR>", { desc = "[T]er[M]inal" } },
    },
    ---@type snacks.Config
    opts = {
      lazygit = {},
      input = { enabled = true },
      terminal = {},
      dashboard = {
        sections = {
          {
            pane = 1,
            {
              section = "terminal",
              cmd = "fortune -s | cowsay",
              hl = "header",
              padding = 1,
              height = 20,
              indent = 8,
            },
          },
          {
            pane = 2,
            { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
            { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
            { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
            { section = "startup" },
            function()
              ---@type snacks.dashboard.Text
              return {
                text = {
                  { "Neovim version: ", hl = "footer" },
                  { tostring(vim.version()), hl = "special" },
                },
                align = "center",
              }
            end,
          },
          {
            pane = 3,
            {
              icon = " ",
              desc = "Browse Repo",
              padding = 1,
              key = "b",
              action = function()
                Snacks.gitbrowse()
              end,
              enabled = function()
                return Snacks.git.get_root() ~= nil
              end,
            },
            {
              icon = " ",
              title = "Git Status",
              section = "terminal",
              enabled = function()
                return Snacks.git.get_root() ~= nil
              end,
              cmd = "git status --short --branch --renames",
              height = 5,
              padding = 1,
              ttl = 5 * 60,
              indent = 3,
            },
          },
        },
      },
    },
  },
}
