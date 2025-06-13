return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    explorer = {
      position = "left",
      width = 30,
    },
    picker = {
      hidden = true,
      -- ignored = true,
      sources = {
        files = {
          hidden = true,
          -- ignored = true,
        },
      },
    },
  },
}
