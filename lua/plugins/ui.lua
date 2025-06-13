return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    indent = { enabled = false },
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
