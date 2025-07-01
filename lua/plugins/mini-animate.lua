return {
  "echasnovski/mini.animate",
  enabled = false,
  config = function()
    return require("mini.animate").setup({
      -- Cursor path
      cursor = {
        -- Whether to enable this animation
        enable = false,
        -- timing = require("mini.animate").gen_timing.cubic({ duration = 50, unit = "total" }),
      },

      -- Vertical scroll
      scroll = {
        -- Whether to enable this animation
        enable = false,
        timing = require("mini.animate").gen_timing.cubic({
          duration = 15,
          unit = "step",
          easing = "in",
        }),
      },

      -- Window resize
      resize = {
        -- Whether to enable this animation
        enable = false,
      },

      -- Window open
      open = {
        -- Whether to enable this animation
        enable = false,
      },

      -- Window close
      close = {
        -- Whether to enable this animation
        enable = false,
      },
    })
  end,
}
