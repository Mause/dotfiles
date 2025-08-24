local function get_lsp_status()
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
        get_lsp_status,
      })
      table.insert(opts.sections.lualine_c, "lsp_status")
      return opts
    end,
  },
}
