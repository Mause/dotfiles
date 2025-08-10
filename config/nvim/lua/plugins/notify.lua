return {
  ---@type LazySpec
  {
    'rcarriga/nvim-notify',
    init = function()
      --      require('notify').setup({
      --        background_colour = '#000000',
      --        stages = 'fade_in_slide_out',
      --        timeout = 3000,
      --        max_height = function()
      --          return math.floor(vim.o.lines * 0.75)
      --        end,
      --      })
      vim.notify = require('notify')
    end,
  },
  {
    'pynappo/git-notify.nvim',
  }
}
