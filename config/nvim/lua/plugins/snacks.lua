function is_github_repo()
  local stdout = vim
    .system({
      "git",
      "remote",
      "-v",
    })
    :wait().stdout

  if stdout == nil then
    return false
  end

  local index = stdout:find("github.com")
  return index ~= nil
end

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
              ---@type snacks.dashboard.Section
              return {
                text = {
                  ---@type snacks.dashboard.Text
                  { "Neovim version: ", hl = "footer" },
                  ---@type snacks.dashboard.Text
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
            function()
              local in_git = Snacks.git.get_root() ~= nil
              local cmds = {
                {
                  title = "Notifications",
                  cmd = "gh notify -s -a -n5",
                  action = function()
                    vim.ui.open("https://github.com/notifications")
                  end,
                  key = "n",
                  icon = " ",
                  height = 5,
                  enabled = true,
                },
                {
                  title = "Open Issues",
                  cmd = "gh issue list -L 3",
                  key = "i",
                  action = function()
                    vim.fn.jobstart("gh issue list --web", { detach = true })
                  end,
                  enabled = is_github_repo,
                  icon = " ",
                  height = 7,
                },
                {
                  icon = " ",
                  title = "Open PRs",
                  cmd = "gh pr list -L 3",
                  key = "P",
                  action = function()
                    vim.fn.jobstart("gh pr list --web", { detach = true })
                  end,
                  enabled = is_github_repo,
                  height = 7,
                },
                {
                  icon = " ",
                  title = "Git Status",
                  cmd = "git --no-pager diff --stat -B -M -C",
                  height = 10,
                },
              }
              return vim.tbl_map(function(cmd)
                return vim.tbl_extend("force", {
                  section = "terminal",
                  enabled = in_git,
                  padding = 1,
                  ttl = 5 * 60,
                  indent = 3,
                }, cmd)
              end, cmds)
            end,
          },
        },
      },
    },
  },
}
