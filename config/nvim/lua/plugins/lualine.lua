local function get_lsp_progress()
  return require("lsp-progress").progress()
end

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function(_, opts)
      ---@class lualine.Config
      opts = require("lualine").get_config()
      opts.options.theme = "tokyonight"
      table.insert(opts.sections.lualine_c, {
        get_lsp_progress,
      })
      table.insert(opts.sections.lualine_c, {
        "lsp_status",
        ignore_lsp = { "GitHub Copilot" },
      })
      return opts
    end,
  },
}
