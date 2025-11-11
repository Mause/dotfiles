return {
  {
    'saghen/blink.pairs',
    version = '*', -- (recommended) only required with prebuilt binaries
    -- opts = {
    --   highlights = {
    --     enabled = true,
    --   }
    -- },
  },
  -- lazy.nvim
  {
    'saghen/blink.indent',
    --- @module 'blink.indent'
    --- @type blink.indent.Config
    -- opts = {},
  },
  {
    "Saghen/blink.cmp",
    version = "1.*",
    opts = {
      keymap = { preset = "default" },
      completion = {
        menu = {
          draw = {
            columns = {
              { "kind_icon" },
              { "label",    "label_description", "source_name", gap = 1 },
            },
            components = {
              source_name = {
                text = function(ctx)
                  if ctx.source_id == "cmdline" then
                    return
                  end
                  return ctx.source_name --:sub(1, 4)
                end,
              },
            },
          },
        },
      },
    },
  },
}
